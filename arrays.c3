// adapted from https://github.com/ben256dev/butil/blob/main/test/main.c

import std::collections;
import std::io;

fn void main()
{
	List {int} my_array;
    my_array.init(mem);
	my_array.push(1);
	my_array.push(2);
	my_array.push(3);
	my_array.push(4);
	my_array.push(5);
	my_array.push(6);
	my_array.push(7);
	my_array.push(8);
	my_array.push(9);
	my_array.push(10);
	my_array.push(11);

	foreach (x : my_array)
		io::printn(x);
	io::putchar('\n');

	my_array.remove_at(3);

	foreach (x : my_array)
		io::printn(x);
	io::putchar('\n');

	my_array.remove_unordered_at(3);

	foreach (x : my_array)
		io::printn(x);
}
