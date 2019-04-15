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

def _python_pkg_zip_impl(ctx):
    files = " ".join(["%s" % dep.path for dep in ctx.files.deps])
    temp_files = ["%s" % "/".join(f.path.split("/")[2:]) for f in ctx.files.deps]
    temp_files_string = " ".join(temp_files)
    #print(temp_files)

    cmd = """
echo -n "{contents}" | xargs -d ' ' -I % touch -t 200001010000 %
zip -X {args} {path} {contents}
"""

    cmd = cmd.format(
        path = ctx.outputs.zip.path,
        contents = files,
        args = ctx.attr.args,
    )

    copy_cmd = """
    echo -n "{contents}" | xargs -d ' ' -I % cp % @D
    """

    copy_cmd = cmd.format(contents = files)
    ctx.actions.run_shell(
        inputs = ctx.files.deps,
        outputs = temp_files,
        command = copy_cmd,
    )
    #print

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
