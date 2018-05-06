
import sphinx_rtd_theme

html_theme = "sphinx_rtd_theme"

html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]

extensions = ['sphinx.ext.autodoc']

templates_path = ['ntemplates']

source_suffix = '.rst'

master_doc = 'index'

project = u'Studio-1'
copyright = u'2017, Studio-1'
author = u'Rumen Lishkov'

version = u'0.1'

release = u'0.1'

language = None

exclude_patterns = []

pygments_style = 'sphinx'

todo_include_todos = False

html_static_path = ['nstatic']

htmlhelp_basename = 'elx-XXLdoc'

latex_elements = {
}

latex_documents = [
    (master_doc, 'elx-XXL.tex', u'elx-XXL Documentation',
     u'Rumen Lishkov', 'manual'),
]

man_pages = [
    (master_doc, 'elx-xxl', u'elx-XXL Documentation',
     [author], 1)
]

texinfo_documents = [
    (master_doc, 'elx-XXL', u'elx-XXL Documentation',
     author, 'elx-XXL', 'One line description of project.',
     'Miscellaneous'),
]
