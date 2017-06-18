from datetime import datetime

class ShowDate (gdb.Command):
    """Greet the whole world."""

    def __init__ (self):
        super (ShowDate, self).__init__ ("pdate", gdb.COMMAND_USER)

    def invoke (self, arg, from_tty):
        try:
            timstamp = int(arg)
        except ValueError:
            timstamp = int(gdb.parse_and_eval(arg))
        #  print date.fromtimestamp(timstamp).strftime('%F %T %Z')
        print datetime.utcfromtimestamp(timstamp).strftime('%F %T')

ShowDate()
