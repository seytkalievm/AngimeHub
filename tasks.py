import subprocess
import pathlib
import sys

from invoke import task

import known

def get_files_to_check():
    for path in pathlib.Path("").glob("README.md"):
        yield path


@task
def spellcheck(c):

    exit_code = 0

    for tex_path in get_files_to_check():

        tex = tex_path.read_text()
        aspell_output = subprocess.check_output(
            ["aspell", "-t", "--list", "--lang=en_GB"], input=tex, text=True
        )
        incorrect_words = set(aspell_output.split("\n")) - {""} - known.words
        if len(incorrect_words) > 0:
            out = f"In {tex_path} the following words are not known: \n"
            for string in sorted(incorrect_words):
                out += f"{string} \n"
            exit_code = 1

        else:
            out += f"In {tex_path} everything is fine!\n"

        out += '\n'
    
    print(f"::set-output name=output::{out}")

    sys.exit(exit_code)