load("@bazel_skylib//lib:paths.bzl", "paths")

def _pkg_zip_impl(ctx):
    files = " ".join(["%s" % dep.path for dep in ctx.files.deps])

    cmd = """
echo -n "{contents}" | xargs -d ' ' -I % touch -t 200001010000 %
zip -X {args} {path} {contents}
"""

    cmd = cmd.format(
        path = ctx.outputs.zip.path,
        contents = files,
        args = ctx.attr.args,
    )

    ctx.actions.run_shell(
        inputs = ctx.files.deps,
        outputs = [ctx.outputs.zip],
        command = cmd,
    )

pkg_zip = rule(
    implementation = _pkg_zip_impl,
    attrs = {
        "deps": attr.label_list(allow_files = True),
        "args": attr.string(
            mandatory = False,
            default = "-j",
        ),
    },
    outputs = {
        "zip": "pkg_%{name}",
    },
)

# this is working but seems to be writing into the source tree which I think is illegal in bazel
# also generating skylark errors
def _python_pkg_zip_impl(ctx):
    files = " ".join(["%s" % dep.path for dep in ctx.files.deps])

    cmd_part1 = """
file_array=($(echo "{contents}" {part2}
zip {path} {part3}
"""
    cmd_part2 = """| xargs -d ' ' -I SRC bash -c 'src_path=SRC && dest_path=${src_path#*/*/} && mkdir -p `dirname $dest_path` && cp -p $src_path $dest_path && echo $dest_path'))
echo -n "${file_array[@]}" | xargs -d ' ' -I % touch -t 200001010000 %"""
    cmd_part3 = "${file_array[@]}"

    cmd = cmd_part1.format(
        path = ctx.outputs.zip.path,
        contents = files,
        part2 = cmd_part2,
        part3 = cmd_part3,
    )

    ctx.actions.run_shell(
        inputs = ctx.files.deps,
        outputs = [ctx.outputs.zip],
        command = cmd,
    )

python_pkg_zip = rule(
    implementation = _python_pkg_zip_impl,
    attrs = {
        "deps": attr.label_list(allow_files = True),
        "args": attr.string(
            mandatory = False,
            default = "",
        ),
    },
    outputs = {
        "zip": "pkg_%{name}",
    },
)
