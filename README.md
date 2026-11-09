# C3 Language Experiments

Some brief rewrites to C3 for code I wrote in C. C3 seems like a very clean alternative to many of the utilities I've written in C. Operator overloading and the standard library seem particularly promising to me.

First, I tried rewriting my C butil dynamic array test in C3. The interface was surprisingly similar to mine. I noted that C3 doesn't support const foreach or even runtime const which seems like a step in the wrong direction for safety to me.

Next, I rewrote my circle and law of cosines inverse kinematics code in C3. I really appreciate member functions, which the documentation calls methods, but unlike C++ they don't have implicit member access. I hoped there would at least be a ``with`` keyword or something, but there is not. I think this only serves to make things harder to read. I'm tempted to redeclare all the members of the struct I am going to use just to make the member function more readable. I don't know why this was not changed, except for concerns that this introduces "side effects".
