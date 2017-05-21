neocitiesd - A library for Neocities written in D
=================================================

About
-----
This is a wrapper written in D for the REST API of [Neocities.org](https://neocities.org/ "Neocities.org").

Usage
-----
The following example shows how you can use neocitiesd for managing your website's content in a simple D program.
```d
import neocitiesd;
import std.json;
import std.stdio;

void main() {
    auto myNeocities = Neocities("your_user_name", "your_password");
    writeln(myNeocities.info.toPrettyString);
    writeln(myNeocities.upload(["index.html", "images/photo.jpg"]).toPrettyString);
    writeln(myNeocities.list.toPrettyString);
    writeln(myNeocities.remove(["index.html", "images/photo.jpg", "images"]).toPrettyString);
    writeln(myNeocities.list.toPrettyString);
}
```
The library offers the four functions `info` (information about your site), `list` (list of files and directories), `upload` (upload files) and `remove` (delete files and directories). The response values (HTTP codes etc.) are in JSON format.

License
-------
MIT