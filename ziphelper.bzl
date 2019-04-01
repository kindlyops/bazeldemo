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
