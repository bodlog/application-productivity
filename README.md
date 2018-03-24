# applicatoin productivity

This tool is used to build an open source database for macOS applications that are productive, non-productive, and neutral.

## Instructions

1. Touch new bundle identifiers in the appropriate folder (`src/neutral`, `src/nonProductive`, `src/productive`).
2. Once the files are touch run the category generator

    ```swift
    ./main.swift
    ```

3. The result will be an updated Category file in: `bin/category.json`
