load("//:ziphelper.bzl", "pkg_zip")
load(
    "@python//:requirements.bzl",
    "requirement",
    py_requirement = "requirement",
)

# TODO: how do we get the python dependencies into the lambda zip?
# bazel build //antivirus:antivirus_deploy.zip
# unzip -vl bazel-bin/antivirus/pkg_antivirus_deploy.zip
py_library(
    name = "lib",
    srcs = [
        "@com_github_upsidetravel_bucket-antivirus-function//:srcs",
        requirement("certifi"),
        requirement("chardet"),
        requirement("datadog"),
        requirement("decorator"),
        requirement("idna"),
        requirement("requests"),
        requirement("simplejson"),
        requirement("urllib3"),
    ],
    visibility = ["//visibility:public"],
)

pkg_zip(
    name = "antivirus_deploy.zip",
    deps = [
        ":lib",
    ],
)

# genrule(
#     name = "antivirus_deploy",
#     srcs = [
#         "@com_github_upsidetravel_bucket-antivirus-function//:srcs",
#     ],
#     outs = ["antivirus_deploy.zip"],
#     cmd = "$(location requirements.txt) $(location ramlToSwagger2) $(location swagger/3.0/api.yaml) $@",
#     visibility = ["//visibility:public"],
# )
