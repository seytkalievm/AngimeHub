import subprocess
import pathlib
import sys

from invoke import task

import known

def get_files_to_check():
    for path in pathlib.Path("").glob("README.md"):
        yield path

output_file = open('aspell_output.txt', 'w')

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
            output_file.write(f"In {tex_path} the following words are not known: ")
            for string in incorrect_words:
                output_file.write(string)
            exit_code = 1

        else:
            output_file.write(f"In {tex_path} everithing is fine!")

    output_file.close()
    sys.exit(exit_code)