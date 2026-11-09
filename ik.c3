module limb;
import std::math;

enum Reachability : int
{
    REACHABLE,
    INVALID_LIMB_LENGTH,
    ZERO_DISTANCE,
    TOO_FAR,
    TOO_CLOSE,
}

alias Vec2 = float[<2>];
struct Limb {
    Vec2  base;
    Vec2  midjoint;
    Vec2  end_effector;
    Vec2  u;
    float n;
    float r;
    float rr;
    Reachability reachability;
}

fn void Limb.check_reachability(Limb* limb)
{
    if (limb.r <= 0.0f || limb.rr <= 0.0f) {
        limb.reachability = INVALID_LIMB_LENGTH;
        return;
    }

    limb.u = limb.end_effector - limb.base;
    limb.n = limb.u.length_sq();

    if (limb.n == 0.0f) {
        limb.reachability = ZERO_DISTANCE;
        return;
    }

    float radii_sum = limb.r + limb.rr;
    if (limb.n > radii_sum * radii_sum) {
        limb.reachability = TOO_FAR;
        return;
    }

    float radii_diff = math::abs(limb.r - limb.rr);
    if (limb.n < radii_diff * radii_diff) {
        limb.reachability = TOO_CLOSE;
        return;
    }

    limb.reachability = REACHABLE;
}

fn void planar_two_link_solve_circles(Limb* limb)
{
    limb.check_reachability();
    if (limb.reachability != REACHABLE) return;

    float d = math::sqrt(limb.n);
    float x = (limb.n + limb.r * limb.r - limb.rr * limb.rr) / (2.0f * d);
    float y = math::sqrt(limb.r * limb.r - x * x);

    Vec2 uu = limb.u / d;
    Vec2 pp = { -uu.y, uu.x };

    limb.midjoint = limb.base + x * uu + y * pp;
}

fn void planar_two_link_solve_cosines(Limb* limb)
{
    limb.check_reachability();
    if (limb.reachability != REACHABLE) return;

    float d = math::sqrt(limb.n);
    float numerator = limb.r * limb.r + limb.n - limb.rr * limb.rr;
    float denominator = 2.0f * limb.r * d;

    float theta = math::acos(numerator / denominator);
    if (theta != theta) theta = 0.0f;

    float end_effector_angle = math::atan2(limb.u.y, limb.u.x);
    float midjoint_angle = end_effector_angle + theta;

    limb.midjoint = limb.base + limb.r * (Vec2){ math::cos(midjoint_angle), math::sin(midjoint_angle) };
}
