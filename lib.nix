{ lib }:
let
  shape =
    attachDoc
      {
        name = "shape";
        package = "doc.nix";
        description = ''
          `shape` is a set of constructors and attribute sets revolving around the concept of “shape”.

          “Shape” illustrates the structure of values in Nix,
          such as attribute sets, lists, functions, and primitive types.
          It is like types, but Nix does not have a type system,
          so we use “shape” to describe the structure of runtime values.
        '';
        shape = shape.attrs { "..." = shape.any; };
      }
      {
        shape = {
          # constructors
          any =
            attachDoc
              {
                name = "any";
                package = "doc.nix";
                description = "`any` is a constructor creating a `shape` representing any value.";
                shape = shape.user "lib.shape.shape";
              }
              {
                any = {
                  shape = "any";
                };
              };
          bool =
            attachDoc
              {
                name = "bool";
                package = "doc.nix";
                description = "`bool` is a `shape` representing boolean values.";
                shape = shape.user "lib.shape.shape";
              }
              {
                bool = {
                  shape = "bool";
                };
              };
          float =
            attachDoc
              {
                name = "float";
                package = "doc.nix";
                description = "`float` is a `shape` representing floating-point numbers.";
                shape = shape.user "lib.shape.shape";
              }
              {
                float = {
                  shape = "float";
                };
              };
          int =
            attachDoc
              {
                name = "int";
                package = "doc.nix";
                description = "`int` is a `shape` representing integer numbers.";
                shape = shape.user "lib.shape.shape";
              }
              {
                int = {
                  shape = "int";
                };
              };
          string =
            attachDoc
              {
                name = "string";
                package = "doc.nix";
                description = "`string` is a `shape` representing string values.";
                shape = shape.user "lib.shape.shape";
              }
              {
                string = {
                  shape = "string";
                };
              };
          null =
            attachDoc
              {
                name = "null";
                package = "doc.nix";
                description = "`null` is a `shape` representing the `null` value.";
                shape = shape.user "lib.shape.shape";
              }
              {
                null = {
                  shape = "null";
                };
              };
          path =
            attachDoc
              {
                name = "path";
                package = "doc.nix";
                description = "`path` is a `shape` representing filesystem paths.";
                shape = shape.user "lib.shape.shape";
              }
              {
                path = {
                  shape = "path";
                };
              };
          snip =
            attachDoc
              {
                name = "snip";
                package = "doc.nix";
                description = "`snip` is a `shape` representing elided or truncated structures.";
                shape = shape.user "lib.shape.shape";
              }
              {
                snip = {
                  shape = "snip";
                };
              };
          list =
            attachDoc
              {
                name = "list";
                package = "doc.nix";
                description = "`list` is a constructor creating a `shape` representing lists of items of the given `shape`.";
                shape = shape.function (shape.user "lib.shape.shape") (shape.user "lib.shape.shape");
              }
              {
                list = item: {
                  shape = "list";
                  inherit item;
                };
              };
          attrs =
            attachDoc
              {
                name = "attrs";
                package = "doc.nix";
                description = ''
                  `attrs` is a constructor creating a `shape` representing an attribute set.

                  The argument is an attribute set where each attribute's value is a `lib.shape.shape` representing the shape of that attribute's value.

                  You can include an attribute named `...` with the value `any` to indicate that the attribute set may contain additional attributes not explicitly listed.
                '';
                shape = shape.function (shape.attrs { "..." = shape.any; }) (shape.user "lib.shape.shape");
              }
              {
                attrs = attrs: {
                  shape = "attrs";
                  inherit attrs;
                };
              };
          function =
            attachDoc
              {
                name = "function";
                package = "doc.nix";
                description = "`function` is a constructor creating a `shape` representing a function from `arg` to `return`.";
                shape = shape.functionN [ (shape.user "lib.shape.shape") (shape.user "lib.shape.shape") ] (
                  shape.user "lib.shape.shape"
                );
              }
              {
                function = arg: return: {
                  shape = "function";
                  inherit arg return;
                };
              };
          either =
            attachDoc
              {
                name = "either";
                package = "doc.nix";
                description = "`either` is a constructor creating a `shape` representing a value that matches either the left or the right shape.";
                shape = shape.functionN [ (shape.user "lib.shape.shape") (shape.user "lib.shape.shape") ] (
                  shape.user "lib.shape.shape"
                );
              }
              {
                either = left: right: {
                  shape = "either";
                  inherit left right;
                };
              };
          user =
            attachDoc
              {
                name = "user";
                package = "doc.nix";
                description = "`user` is a constructor creating a named user-defined `shape`.";
                shape = shape.function shape.string (shape.user "lib.shape.shape");
              }
              {
                user = name: {
                  shape = "user";
                  inherit name;
                };
              };
          literal =
            attachDoc
              {
                name = "literal";
                package = "doc.nix";
                description = "`literal` is a constructor creating a `shape` representing a literal token name.";
                shape = shape.function shape.string (shape.user "lib.shape.shape");
              }
              {
                literal = name: {
                  shape = "literal";
                  inherit name;
                };
              };
          # utility constructors
          oneOf =
            attachDoc
              {
                name = "oneOf";
                package = "doc.nix";
                description = "`oneOf` is a utility constructor creating a `shape` representing a value that matches one of the given shapes.";
                shape = shape.function (shape.list (shape.user "lib.shape.shape")) (shape.user "lib.shape.shape");
              }
              {
                oneOf =
                  shapes:
                  if lib.length shapes == 1 then
                    lib.head shapes
                  else
                    shape.either (lib.head shapes) (shape.oneOf (lib.tail shapes));
              };
          functionN =
            attachDoc
              {
                name = "functionN";
                package = "doc.nix";
                description = "`functionN` is a utility constructor creating a multi-parameter function `shape`.";
                shape = shape.functionN [
                  (shape.list (shape.user "lib.shape.shape"))
                  (shape.user "lib.shape.shape")
                ] (shape.user "lib.shape.shape");
              }
              {
                functionN =
                  args: return:
                  if lib.length args == 0 then
                    return
                  else
                    shape.function (lib.head args) (shape.functionN (lib.tail args) return);
              };
          # shape of `shape`
          shape =
            attachDocShape
              {
                name = "shape";
                package = "doc.nix";
                description = "`shape` is an attribute set representing the shape of the “shape”.";
              }
              {
                shape = shape.either shape.string (
                  shape.attrs {
                    shape = shape.string;
                    "..." = shape.any;
                  }
                );
              };
        };
      };

  doc.shape =
    attachDocShape
      {
        name = "shape";
        package = "doc.nix";
        description = "`doc.shape` describes the structure of a doc.nix document for values and shapes.";
      }
      {
        shape =
          shape.either
            (shape.attrs {
              level = shape.literal "value";
              name = shape.string;
              description = shape.string;
              package = shape.string;
              hide = shape.bool;
              shape = shape.user "shape.shape";
              shapeAll = shape.user "shape.shape";
              pos = shape.attrs {
                file = shape.string;
                line = shape.int;
                column = shape.int;
              };
            })
            (
              shape.attrs {
                level = shape.literal "shape";
                name = shape.string;
                description = shape.string;
                package = shape.string;
                definition = shape.user "shape.shape";
                pos = shape.attrs {
                  file = shape.string;
                  line = shape.int;
                  column = shape.int;
                };
              }
            );
      };

  makeShape =
    attachDoc
      {
        name = "makeShape";
        package = "doc.nix";
        description = "`makeShape` generates a `shape` that can be derived automatically from a value.";
        shape = shape.function shape.any (shape.user "shape.shape");
      }
      {
        makeShape =
          value:
          let
            maxDepth = 2;
            go =
              depth: value:
              if depth >= maxDepth then
                shape.snip
              else if lib.isBool value then
                shape.bool
              else if lib.isFloat value then
                shape.float
              else if lib.isInt value then
                shape.int
              else if lib.isString value then
                shape.string
              else if builtins.isNull value then
                shape.null
              else if lib.isPath value then
                shape.path
              else if lib.isList value then
                let
                  itemShapes = lib.unique (lib.map (go (depth + 1)) value);
                  accumulate =
                    shapes:
                    if lib.length shapes == 1 then
                      lib.head shapes
                    else
                      shape.either (lib.head shapes) (accumulate (lib.tail shapes));
                in
                shape.list (accumulate itemShapes)
              else if lib.isAttrs value then
                shape.attrs (lib.mapAttrs (n: v: go (depth + 1) v) value)
              else if lib.isFunction value then
                let
                  arg =
                    if lib.functionArgs value == { } then
                      # Cannot tell if this is truly { } or just a variable, so use any
                      shape.any
                    else
                      shape.attrs (
                        lib.mapAttrs' (n: optional: {
                          name = if optional then "${n}?" else n;
                          value = shape.any;
                        }) (lib.functionArgs value)
                      );
                in
                shape.function arg shape.any
              else
                abort "unexpected branch";
          in
          go 0 value;
      };

  getDoc =
    attachDoc
      {
        name = "getDoc";
        package = "doc.nix";
        description = "`getDoc` returns an existing doc.nix document if present; otherwise it derives documentation from the value.";
        shape = shape.function shape.any (shape.user "doc.shape");
      }
      {
        getDoc =
          value:
          if lib.isAttrs value && value ? "doc.nix" then
            value."doc.nix"
          else
            {
              name = null;
              description = null;
              package = null;
              shape = makeShape value;
            };
      };

  attachDoc =
    let
      attrs.attachDoc =
        {
          name ? null,
          description ? null,
          package ? null,
          shape ? null,
          hide ? false,
        }:
        attrs:
        let
          name' =
            if name == null then
              let
                names = lib.attrNames attrs;
              in
              if lib.length names == 1 then
                lib.head names
              else
                abort "attachDoc's first argument's `name` attribute must be specified when the second argument has multiple attributes."
            else
              name;
          value = attrs."${name'}";
          removeHidden =
            value:
            if lib.isAttrs value then
              lib.filterAttrs (n: v: if lib.isAttrs v then !v."doc.nix".hide or false else true) value
            else
              value;
        in
        if
          lib.isBool value
          || lib.isFloat value
          || lib.isInt value
          || lib.isList value
          || lib.isString value
          || builtins.isNull value
          || lib.isPath value
          || lib.isAttrs value && value ? "doc.nix"
        then
          value
        else
          let
            doc = {
              "doc.nix" = {
                level = "value";
                name = name';
                inherit
                  description
                  package
                  hide
                  ;
                shape = if shape == null then makeShape (removeHidden value) else shape;
                shapeAll = makeShape value;
                pos =
                  let
                    pos = lib.unsafeGetAttrPos name' attrs;
                  in
                  pos // { file = removeStoreDir pos.file; };
              };
            };
          in
          if lib.isAttrs value then
            assert !value ? "doc.nix";
            let
              value' = lib.mapAttrs (
                n: v:
                attachDoc {
                  inherit package;
                } { "${n}" = v; }
              ) value;
            in
            value' // doc
          else if lib.isFunction value then
            { __functor = self: value; } // doc
          else
            abort "unexpected branch";
    in
    {
      __functor = self: attrs.attachDoc;
      "doc.nix" = {
        level = "value";
        name = "attachDoc";
        package = "doc.nix";
        description = ''
          `attachDoc` attaches documentation to a value.

          If the value already has a nix.doc document, it is returned as is. If it is neither an attribute set nor a function, it is returned without documentation attached.

          # Parameters

          - attribute set of documentation metadata:
            - `name`: `name` is string and optional; it specifies the name of the shape being documented. If not provided, the name is inferred from the second argument.
            - `description`: `description` is string and optional; it provides a description for the shape.
            - `package`: `package` is string and optional; it specifies the package name where the shape is defined.
            - `shape`: `shape` is shape and optional; if not provided, the shape is inferred from the value.
            - `hide`: `hide` is bool and optional; if true, the documentation will be hidden from generated document sets.
          - attribute set that has value definition; when one attribute is present, its name is used as the name of the shape, otherwise the `name` attribute of the first argument is used to select an attribute. This parameter is an attribute set rather than a shape value because the file location where the shape is defined can be retrieved.
        '';
        shape =
          shape.functionN
            [
              (shape.attrs {
                name = shape.string;
                "description?" = shape.string;
                "package?" = shape.string;
                "shape?" = shape.user "shape.shape";
                "hide?" = shape.bool;
              })
              (shape.attrs { "\"\${name}\"" = shape.any; })
            ]
            (
              shape.oneOf [
                shape.bool
                shape.float
                shape.int
                (shape.list shape.any)
                shape.string
                shape.null
                shape.path
                (shape.attrs {
                  "doc.nix" = shape.user "doc.shape";
                  "..." = shape.any;
                })
              ]
            );
        shapeAll = makeShape attrs.attachDoc;
        pos =
          let
            pos = lib.unsafeGetAttrPos "attachDoc" attrs;
          in
          pos // { file = removeStoreDir pos.file; };
      };
    };

  attachDocShape =
    attachDoc
      {
        name = "attachDocShape";
        package = "doc.nix";
        description = ''
          `attachDocShape` attaches documentation to a shape definition; if a doc.nix document already exists it is returned unchanged.

          # Parameters

          - attribute set of documentation metadata:
            - `name`: `name` is string and optional; it specifies the name of the shape being documented. If not provided, the name is inferred from the second argument.
            - `description`: `description` is string and optional; it provides a description for the shape.
            - `package`: `package` is string and optional; it specifies the package name where the shape is defined.
            - `hide`: `hide` is bool and optional; if true, the documentation will be hidden from generated document sets.
          - attribute set that has shape definition; when one attribute is present, its name is used as the name of the shape, otherwise the `name` attribute of the first argument is used to select an attribute. This parameter is an attribute set rather than a shape value because the file location where the shape is defined can be retrieved.
        '';
        shape = shape.functionN [
          (shape.attrs {
            "name?" = shape.string;
            "description?" = shape.string;
            "package?" = shape.string;
            "hide?" = shape.bool;
          })
          (shape.attrs { "\"\${name}\"" = shape.user "shape.shape"; })
        ] (shape.user "shape.shape");
      }
      {
        attachDocShape =
          {
            name ? null,
            description ? null,
            package ? null,
            hide ? false,
          }:
          attrs:
          let
            name' =
              if name == null then
                let
                  names = lib.attrNames attrs;
                in
                if lib.length names == 1 then
                  lib.head names
                else
                  abort "attachDoc's first argument's `name` attribute must be specified when the second argument has multiple attributes."
              else
                name;
            shape = attrs."${name'}";
          in
          if lib.isAttrs shape && shape ? "doc.nix" then
            shape
          else
            shape
            // {
              "doc.nix" = {
                level = "shape";
                name = name';
                inherit
                  description
                  package
                  hide
                  ;
                definition = shape;
                pos =
                  let
                    pos = lib.unsafeGetAttrPos name' attrs;
                  in
                  pos // { file = removeStoreDir pos.file; };
              };
            };
      };

  removeStoreDir = path: lib.substring (lib.stringLength (builtins.toString ./.) + 1) (-1) path;

  detachDoc =
    attachDoc
      {
        name = "detachDoc";
        package = "doc.nix";
        description = "`detachDoc` removes any attached doc.nix documentation from a value recursively.";
        shape = shape.function shape.any shape.any;
      }
      {
        detachDoc =
          value:
          if lib.isAttrs value then
            let
              attrs = lib.mapAttrs (_: v: detachDoc v) (lib.removeAttrs value [ "doc.nix" ]);
            in
            if lib.isFunction value then # `value` is a functor
              let
                functor = {
                  __functor = self: detachDoc (attrs.__functor self);
                };
              in
              if lib.length (lib.attrNames attrs) == 1 then # `value` has form of `{ __functor = ...; "nix.doc" = ...; }`
                functor.__functor functor
              else
                attrs // functor
            else
              attrs
          else
            value;
      };

  makeDocSet =
    attachDoc
      {
        name = "makeDocSet";
        package = "doc.nix";
        description = "`makeDocSet` builds a document set from a value and its attributes.";
        shape = shape.functionN [
          (shape.attrs {
            "showHidden?" = shape.bool;
          })
          (shape.any)
        ] (shape.list (shape.user "doc.shape"));
      }
      {
        makeDocSet =
          opts@{
            showHidden ? false,
          }:
          value:
          if !lib.isAttrs value || !value ? "doc.nix" then
            [ ]
          else
            let
              doc = getDoc value;
              attrs = lib.removeAttrs value [ "doc.nix" ];
              attrList = lib.attrValues attrs;
              childDocSet = lib.map (d: d // { name = "${doc.name}.${d.name}"; }) (
                lib.concatMap (makeDocSet opts) (lib.filter (v: showHidden || !(getDoc v).hide or false) attrList)
              );
            in
            [ doc ] ++ (if doc.level == "value" then childDocSet else [ ]);
      };

  shapeToDoc =
    let
      shapeToDoc' =
        let
          parens = a: "(${a})";
          # Operator precedence (larger numbers mean higher precedence)
          prec = {
            top = 0; # top level
            either = 1; # or operator
            arrow = 2; # -> operator
            atom = 3; # atomic expression
          };
        in
        p: i: s:
        if builtins.isNull s then
          "null"
        else if s.shape or null == "any" then
          "any"
        else if s.shape or null == "bool" then
          "bool"
        else if s.shape or null == "int" then
          "int"
        else if s.shape or null == "float" then
          "float"
        else if s.shape or null == "string" then
          "string"
        else if s.shape or null == "null" then
          "null"
        else if s.shape or null == "path" then
          "path"
        else if s.shape or null == "snip" then
          "<snip>"
        else if s.shape == "list" then
          "[${shapeToDoc' prec.atom i s.item}]"
        else if s.shape == "attrs" then
          if s.attrs ? "__functor" && s.attrs ? "doc.nix" && lib.length (lib.attrNames s.attrs) == 2 then
            shapeToDoc' p i s.attrs."__functor"
          else
            let
              indent = lib.concatStrings (lib.replicate i "  ");
              nextIndent = lib.concatStrings (lib.replicate (i + 1) "  ");
              ellipsis = s.attrs ? "...";
              items =
                (lib.mapAttrsToList (
                  n: v:
                  "${nextIndent}${if lib.hasInfix "." n then "\"${n}\"" else n} = ${shapeToDoc' prec.atom (i + 1) v};"
                ) (lib.filterAttrs (x: _: x != "...") s.attrs))
                ++ (if ellipsis then [ "${nextIndent}...;" ] else [ ]);
              formatted = lib.concatStringsSep "\n" items;
            in
            "{\n${formatted}\n${indent}}"
        else if s.shape == "function" then
          (if p > prec.arrow then parens else lib.id)
            "${shapeToDoc' prec.arrow i s.arg} -> ${shapeToDoc' prec.top i s.return}"
        else if s.shape == "either" then
          (if p > prec.either then parens else lib.id)
            "${shapeToDoc' prec.either i s.left} or ${shapeToDoc' prec.either i s.right}"
        else if s.shape == "user" then
          s.name
        else if s.shape == "literal" then
          "\"${s.name}\""
        else
          abort "unexpected branch: ${s.shape}";
    in
    shapeToDoc' 0 0;

  makeSingleCommonMark =
    attachDoc
      {
        name = "makeSingleCommonMark";
        package = "doc.nix";
        description = "`makeSingleCommonMark` renders a CommonMark string from a single document.";
        shape = shape.functionN [
          (shape.attrs {
            "showHidden?" = shape.bool;
          })
          (shape.user "doc.shape")
        ] shape.string;
      }
      {
        makeSingleCommonMark =
          {
            showHidden ? false,
          }:
          doc:
          let
            name =
              let
                v = doc.name or "\\<unnamed>";
              in
              if builtins.isNull v then "\\<unnamed>" else v;
            description =
              if !doc ? description || doc.description == null then
                "No description provided."
              else
                let
                  lines = lib.splitString "\n" doc.description;
                  lines' = lib.map (l: if lib.hasPrefix "#" l then "##${l}" else l) lines;
                in
                lib.concatStringsSep "\n" lines';
            package =
              let
                v = doc.package or "\\<unset>";
              in
              if builtins.isNull v then "\\<unset>" else v;
            shape' = if doc ? shape then shapeToDoc doc.shape else "\\<unset>";
            shapeInferred = if doc ? shapeAll then shapeToDoc doc.shapeAll else "\\<unset>";
            file =
              if !doc ? pos || doc.pos == null then
                "\\<unknown>"
              else
                let
                  pos = doc.pos;
                in
                "[${pos.file}:${toString pos.line}](${pos.file}#L${toString pos.line}):${toString pos.column}";
          in
          if doc.level == "value" then
            ''
              ## ${name}

              ${description}

              ### Shape

              ```
              ${shape'}
              ```
              ${
                if showHidden then
                  ''

                    ### Shape (inferred)

                    ```
                    ${shapeInferred}
                    ```

                  ''
                else
                  ""
              }
              ### Package

              ${package}

              ### File

              ${file}
            ''
          else if doc.level == "shape" then
            ''
              ## ${name}

              ${description}

              **Definition**

              ```
              ${shapeToDoc doc.definition}
              ```

              ### Package

              ${package}

              ### File

              ${file}
            ''
          else
            abort "unexpected branch";
      };

  makeCommonMark =
    attachDoc
      {
        name = "makeCommonMark";
        package = "doc.nix";
        description = "`makeCommonMark` renders a CommonMark string from a document set.";
        shape = shape.functionN [
          (shape.attrs {
            "showHidden?" = shape.bool;
          })
          (shape.list (shape.user "doc.shape"))
        ] shape.string;
      }
      {
        makeCommonMark =
          {
            showHidden ? false,
          }:
          docSet:
          assert lib.isList docSet;
          lib.concatMapStringsSep "\n" (makeSingleCommonMark { inherit showHidden; }) docSet;
      };

  what's =
    attachDoc
      {
        name = "what's";
        package = "doc.nix";
        description = "`what's` is for debugging: it prints documentation for a value and aborts.";
      }
      {
        what's =
          v:
          let
            markdown = makeSingleCommonMark { } (getDoc v);
          in
          builtins.trace "\n${markdown}" (abort "`what's` called");
      };
in
attachDoc
  {
    name = "lib";
    package = "doc.nix";
    description = "Library functions for doc.nix.";
  }
  {
    lib = {
      inherit
        shape
        doc
        getDoc
        attachDoc
        attachDocShape
        detachDoc
        makeDocSet
        makeSingleCommonMark
        makeCommonMark
        what's
        ;
      internal =
        attachDoc
          {
            name = "internal";
            package = "doc.nix";
            hide = true;
          }
          {
            internal = {
              inherit makeShape;
            };
          };
    };
  }
