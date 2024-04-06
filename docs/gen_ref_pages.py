"""Generate the code reference pages and navigation.

From https://mkdocstrings.github.io/recipes/
"""

from pathlib import Path

import mkdocs_gen_files

with Path("README.md").open("r") as readme, mkdocs_gen_files.open(
    "index.md", "w", encoding="utf-8"
) as index_file:
    index_file.writelines(readme.read())
