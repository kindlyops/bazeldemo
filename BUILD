config_setting(
    name = "linux",
    values = {"cpu": "k8"},  # don't ask...
    visibility = ["//visibility:public"],
)

config_setting(
    name = "darwin",
    values = {"cpu": "darwin"},
    visibility = ["//visibility:public"],
)

load("@com_github_bazelbuild_buildtools//buildifier:def.bzl", "buildifier")

buildifier(
    name = "buildifier",
)

buildifier(
    name = "buildifier-check",
    mode = "check",
)

load("//:ziphelper.bzl", "pkg_zip")

# pkg_zip(
#     name = "antivirus_stuff.zip",
#     deps = [
#         "@upside_bucket_antivirus//:build_av_artifacts",
#     ],
# )

load("@bazel_gazelle//:def.bzl", "gazelle")

# gazelle:prefix github.com/example/project
gazelle(name = "gazelle")

genrule(
    name = "touch",
    srcs = [],
    outs = ["timestamp.txt"],
    cmd = "touch $@",
)
