load(
    "@python//:requirements.bzl",
    "requirement",
    py_requirement = "requirement",
)

py_binary(
    name = "python_lambda_zipper",
    srcs = ["python_lambda_zipper.py"],
)

genrule(
    name = "antivirus_lambda",
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
    outs = ["pkg_antivirus_deploy.zip"],
    cmd = "$(location :python_lambda_zipper) -o $@ $(SRCS)",
    tools = [":python_lambda_zipper"],
)
