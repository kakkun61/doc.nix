# doc.nix

doc.nix is a documentation generator for Nix runtime values.

````
nix-repl> lib.what's lib.makeCommonMark
trace:
## makeCommonMark

`makeCommonMark` renders a CommonMark string from a document set.

### Shape

```
{
  showHidden? = bool;
} -> [doc.shape] -> string
```

### Package

doc.nix

### File

lib.nix:861:9
````

````
nix-repl> lib.what's lib.doc.shape
trace:
## shape

`doc.shape` describes the structure of a doc.nix document for values and shapes.

**Definition**

```
{
  description = string;
  hide = bool;
  level = "value";
  name = string;
  package = string;
  pos = {
    column = int;
    file = string;
    line = int;
  };
  shape = shape.shape;
  shapeAll = shape.shape;
} or {
  definition = shape.shape;
  description = string;
  level = "shape";
  name = string;
  package = string;
  pos = {
    column = int;
    file = string;
    line = int;
  };
}
```

### Package

doc.nix

### File

lib.nix:282:9
````

## lib.nix

See [lib.md] for API documentation.

[lib.md]: ./lib.md

## Notice

This is not a replacement for [nixdoc] nor [docnix].

[nixdoc]: https://github.com/nix-community/nixdoc
[docnix]: https://github.com/nix-community/docnix
