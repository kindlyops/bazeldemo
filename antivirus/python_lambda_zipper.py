import argparse
import os
from zipfile import ZipFile, ZIP_DEFLATED

def trim(src):
    # strip first two directory components
    trimmed = "/".join(src.split("/")[2:])
    return trimmed


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-o", "--output")
    parser.add_argument('sources', nargs='*')
    args = parser.parse_args()
    atime = 946684800 # 2000-01-01T00:00:00Z
    mtime = atime
    times = (atime, mtime)

    with ZipFile(args.output, 'w') as lambda_zip:
        for src in args.sources:
            # we do this kind of ugly hack to reset the timestamps on the source
            # files that we are adding to the zip because that gives us reproducible
            # zip files (creating zip files with the same contents twice in a row
            # results in a zip file with the same hash)
            os.utime(src, times)
            lambda_zip.write(src, trim(src), ZIP_DEFLATED)