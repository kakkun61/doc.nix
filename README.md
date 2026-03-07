# doc.nix

doc.nix helps when Nix docs drift from runtime values by attaching docs to values/shapes, inspecting in `nix repl`, and rendering Markdown from the same source.

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

## API docs

See [lib.md] for API documentation.

[lib.md]: ./lib.md

## Notice

doc.nix complements [nixdoc] and [docnix]; it does not replace them.

[nixdoc]: https://github.com/nix-community/nixdoc
[docnix]: https://github.com/nix-community/docnix
