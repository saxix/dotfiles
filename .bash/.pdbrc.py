import pdb


class Config(pdb.DefaultConfig):
    current_line_color = 40
    highlight = True
    encoding = 'utf-8'
    sticky_by_default = True  # False
    editor = '${EDITOR:-vi}'

    def setup(self, pdb):
        pass
