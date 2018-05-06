
import sphinx_rtd_theme

html_theme = "sphinx_rtd_theme"

html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]

extensions = ['sphinx.ext.autodoc']

templates_path = ['ntemplates']

source_suffix = '.rst'

master_doc = 'index'

project = u'rancher-catalog-xxl'
copyright = u'2018, rumen.pro'
author = u'Rumen Lishkov'

version = u'0.1'

release = u'0.1'

language = None

exclude_patterns = []

pygments_style = 'sphinx'

todo_include_todos = False

html_static_path = ['nstatic']

htmlhelp_basename = 'rancher-catalog-xxl'

latex_elements = {
}

latex_documents = [
    (master_doc, 'erancher-catalog-xxl.tex', u'rancher-catalog-xxl Documentation',
     u'Rumen Lishkov', 'manual'),
]

man_pages = [
    (master_doc, 'rancher-catalog-xxl', u'rancher-catalog-xxl Documentation',
     [author], 1)
]

texinfo_documents = [
    (master_doc, 'rancher-catalog-xxl', u'rancher-catalog-xxl Documentation',
     author, 'rancher-catalog-xxl', 'One line description of project.',
     'Miscellaneous'),
]
