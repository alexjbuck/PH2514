using PkgTemplates

t = Template(
    user="alexjbuck",
    authors="Alexander Buck",
    plugins=[
        License(; name="MIT"),
        TravisCI(),
    ]
)

generate("PH2514",t)
