# doc.nix library documentation

This document is generated and do not edit manually.

## lib

Library functions for doc.nix.

### Shape

```
{
  attachDoc = <snip>;
  attachDocShape = <snip>;
  detachDoc = <snip>;
  doc = {
    shape = <snip>;
  };
  getDoc = <snip>;
  makeCommonMark = <snip>;
  makeDocSet = <snip>;
  makeSingleCommonMark = <snip>;
  shape = {
    any = <snip>;
    attrs = <snip>;
    bool = <snip>;
    "doc.nix" = <snip>;
    either = <snip>;
    float = <snip>;
    function = <snip>;
    functionN = <snip>;
    int = <snip>;
    list = <snip>;
    literal = <snip>;
    null = <snip>;
    oneOf = <snip>;
    path = <snip>;
    shape = <snip>;
    snip = <snip>;
    string = <snip>;
    user = <snip>;
  };
  what's = <snip>;
}
```

### Package

doc.nix

### File

[lib.nix:893](lib.nix#L893):5

## lib.attachDoc

`attachDoc` attaches documentation to a value.

If the value already has a nix.doc document, it is returned as is without additional attachment. If the value is not an attribute set nor a function, it is returned as is without attaching documentation.

### Parameters

- attribute set of documentation metadata:
  - `name`: `name` is string and optional; it specifies the name of the shape being documented. If not provided, the name is inferred from the second argument.
  - `description`: `description` is string and optional; it provides a description for the shape.
  - `package`: `package` is string and optional; it specifies the package name where the shape is defined.
  - `shape`: `shape` is shape and optional; if not provided, the shape is inferred from the value.
  - `hide`: `hide` is bool and optional; if true, the documentation will be hidden from generated document sets.
- attribute set that has value definition; when one attribute is present, its name is used as the name of the shape, otherwise the `name` attribute of the first argument is used to select an attribute. This parameter is an attribute set rather than a shape value because the file location where the shape is defined can be retrieved.


### Shape

```
{
  description? = string;
  hide? = bool;
  name = string;
  package? = string;
  shape? = shape.shape;
} -> {
  "${name}" = any;
} -> bool or float or int or [any] or string or null or path or {
  "doc.nix" = doc.shape;
  ...;
}
```

### Package

doc.nix

### File

[lib.nix:401](lib.nix#L401):7

## lib.attachDocShape

`attachDocShape` attaches documentation to a shape definition; if a doc.nix document already exists it is returned unchanged.

### Parameters

- attribute set of documentation metadata:
  - `name`: `name` is string and optional; it specifies the name of the shape being documented. If not provided, the name is inferred from the second argument.
  - `description`: `description` is string and optional; it provides a description for the shape.
  - `package`: `package` is string and optional; it specifies the package name where the shape is defined.
  - `hide`: `hide` is bool and optional; if true, the documentation will be hidden from generated document sets.
- attribute set that has shape definition; when one attribute is present, its name is used as the name of the shape, otherwise the `name` attribute of the first argument is used to select an attribute. This parameter is an attribute set rather than a shape value because the file location where the shape is defined can be retrieved.


### Shape

```
{
  description? = string;
  hide? = bool;
  name? = string;
  package? = string;
} -> {
  "${name}" = shape.shape;
} -> shape.shape
```

### Package

doc.nix

### File

[lib.nix:563](lib.nix#L563):9

## lib.detachDoc

`detachDoc` removes any attached doc.nix documentation from a value recursively.

### Shape

```
any -> any
```

### Package

doc.nix

### File

[lib.nix:619](lib.nix#L619):9

## lib.doc

No description provided.

### Shape

```
{
  shape = {
    "doc.nix" = <snip>;
    left = <snip>;
    right = <snip>;
    shape = <snip>;
  };
}
```

### Package

doc.nix

### File

[lib.nix:469](lib.nix#L469):21

## lib.doc.shape

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

[lib.nix:282](lib.nix#L282):9

## lib.getDoc

`getDoc` returns an existing doc.nix document if present; otherwise it derives documentation from the value.

### Shape

```
any -> doc.shape
```

### Package

doc.nix

### File

[lib.nix:386](lib.nix#L386):9

## lib.makeCommonMark

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

[lib.nix:861](lib.nix#L861):9

## lib.makeDocSet

`makeDocSet` builds a document set from a value and its attributes.

### Shape

```
{
  showHidden? = bool;
} -> any -> [doc.shape]
```

### Package

doc.nix

### File

[lib.nix:655](lib.nix#L655):9

## lib.makeSingleCommonMark

`makeSingleCommonMark` renders a CommonMark string from a single document.

### Shape

```
{
  showHidden? = bool;
} -> doc.shape -> string
```

### Package

doc.nix

### File

[lib.nix:754](lib.nix#L754):9

## lib.shape

`shape` is a set of constructors and attribute sets revolving around the concept of “shape”.

“Shape” illustrates the structure of values in Nix,
such as attribute sets, lists, functions, and primitive types.
It is like types, but Nix does not have a type system,
so we use “shape” to describe the structure of runtime values.


### Shape

```
{
  ...;
}
```

### Package

doc.nix

### File

[lib.nix:19](lib.nix#L19):9

## lib.shape.any

`any` is a constructor creating a `shape` representing any value.

### Shape

```
lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:30](lib.nix#L30):17

## lib.shape.attrs

`attrs` is a constructor creating a `shape` representing an attribute set.

The argument is an attribute set where each attribute's value is a `lib.shape.shape` representing the shape of that attribute's value.

You can include an attribute named `...` with the value `any` to indicate that the attribute set may contain additional attributes not explicitly listed.


### Shape

```
{
  ...;
} -> lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:154](lib.nix#L154):17

## lib.shape.bool

`bool` is a `shape` representing boolean values.

### Shape

```
lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:43](lib.nix#L43):17

## lib.shape.either

`either` is a constructor creating a `shape` representing a value that matches either the left or the right shape.

### Shape

```
lib.shape.shape -> lib.shape.shape -> lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:186](lib.nix#L186):17

## lib.shape.float

`float` is a `shape` representing floating-point numbers.

### Shape

```
lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:56](lib.nix#L56):17

## lib.shape.function

`function` is a constructor creating a `shape` representing a function from `arg` to `return`.

### Shape

```
lib.shape.shape -> lib.shape.shape -> lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:170](lib.nix#L170):17

## lib.shape.functionN

`functionN` is a utility constructor creating a multi-parameter function `shape`.

### Shape

```
[lib.shape.shape] -> lib.shape.shape -> lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:248](lib.nix#L248):17

## lib.shape.int

`int` is a `shape` representing integer numbers.

### Shape

```
lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:69](lib.nix#L69):17

## lib.shape.list

`list` is a constructor creating a `shape` representing lists of items of the given `shape`.

### Shape

```
lib.shape.shape -> lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:134](lib.nix#L134):17

## lib.shape.literal

`literal` is a constructor creating a `shape` representing a literal token name.

### Shape

```
string -> lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:214](lib.nix#L214):17

## lib.shape.null

`null` is a `shape` representing the `null` value.

### Shape

```
lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:95](lib.nix#L95):17

## lib.shape.oneOf

`oneOf` is a utility constructor creating a `shape` representing a value that matches one of the given shapes.

### Shape

```
[lib.shape.shape] -> lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:229](lib.nix#L229):17

## lib.shape.path

`path` is a `shape` representing filesystem paths.

### Shape

```
lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:108](lib.nix#L108):17

## lib.shape.shape

`shape` is an attribute set representing the shape of the “shape”.

**Definition**

```
string or {
  shape = string;
  ...;
}
```

### Package

doc.nix

### File

[lib.nix:264](lib.nix#L264):17

## lib.shape.snip

`snip` is a `shape` representing elided or truncated structures.

### Shape

```
lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:121](lib.nix#L121):17

## lib.shape.string

`string` is a `shape` representing string values.

### Shape

```
lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:82](lib.nix#L82):17

## lib.shape.user

`user` is a constructor creating a named user-defined `shape`.

### Shape

```
string -> lib.shape.shape
```

### Package

doc.nix

### File

[lib.nix:200](lib.nix#L200):17

## lib.what's

`what's` is for debugging: it prints documentation for a value and aborts.

### Shape

```
any -> any
```

### Package

doc.nix

### File

[lib.nix:878](lib.nix#L878):9

