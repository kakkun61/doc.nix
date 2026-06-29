# doc.nix

doc.nix helps when Nix docs drift from runtime values by attaching docs to values/shapes, inspecting in `nix repl`, and rendering Markdown from the same source.

Typical usage is using `lib.what's`:

````
nix-repl> :load-flake .
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

[`lib.what's`] is an entry point function that is provided by doc.nix. It prints documentation for a given value and aborts evaluation. Wrap a value with `lib.what's`, such as `(lib.what's foo)`, to inspect it when its content or shape is unclear.

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

Following is how to import doc.nix's `lib` in your Nix code:

```nix
{
  inputs = {
    …
    doc-nix.url = "github:kakkun61/doc.nix";
  };

  outputs = { …, doc-nix }:
    {
      # Using `doc-nix.lib`
    };
}
```

or import [_lib.nix_] directly when you don't use flakes.

Use [`lib.attachDoc`] when you are library author. When you have `foo` variable and want to attach documentation to it, you can do:

```nix
lib.attachDoc {} { inherit foo; };
```

You can add detailed information with the first argument, see [`lib.attachDoc`] for details.


The second argument can be simply `foo`, but using `{ inherit foo; }` is recommended due to limitations in `pkgs.lib.unsafeGetAttrPos`. Because doc.nix uses `pkgs.lib.unsafeGetAttrPos` to retrieve the position in the source file, it cannot directly determine the position of a variable; it only works for attributes within an attribute set.

[`lib.makeCommonMark`] renders a Markdown string from a document set. You can use it to generate Markdown documentation for your library. The document set is made by [`lib.makeDocSet`]. So you can make a Markdown documentation file like this:

```nix
pkgs.writeText "doc.md" ''
  # Your library documentation

  This document is auto-generated and do not edit manually.

  ${lib.makeCommonMark { } (lib.makeDocSet { } yourLibrary)}
'';
```

[_flake.nix_] in this repository contains an example of generating a Markdown document for the library itself.

[_lib.nix_]: ./lib.nix
[_flake.nix_]: ./flake.nix
[`lib.what's`]: ./lib.md#libwhats
[`lib.attachDoc`]: ./lib.md#libattachdoc
[`lib.makeCommonMark`]: ./lib.md#libmakecommonmark
[`lib.makeDocSet`]: ./lib.md#libmakedocset

## API docs

See [_lib.md_] for API documentation.

[_lib.md_]: ./lib.md

## Notice

doc.nix complements [nixdoc] and [docnix]; it does not replace them.

[nixdoc]: https://github.com/nix-community/nixdoc
[docnix]: https://github.com/nix-community/docnix
