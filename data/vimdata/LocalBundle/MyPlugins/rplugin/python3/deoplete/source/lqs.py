# ============================================================================
# FILE: dictionary.py
# AUTHOR: Shougo Matsushita <Shougo.Matsu at gmail.com>
# License: MIT license
# ============================================================================

from os.path import getmtime, dirname, realpath
from collections import namedtuple
from .base import Base

DictCacheItem = namedtuple('DictCacheItem', 'mtime candidates')


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'lqs'
        self.mark = '[LQS]'
        self.filetypes = ['sql']

        self.__cache = {}

    def on_event(self, context):
        self.__make_cache(context)

    def gather_candidates(self, context):
        self.__make_cache(context)

        candidates = []
        for filename in [x for x in self.__get_dictionaries(context)
                         if x in self.__cache]:
            candidates.append(self.__cache[filename].candidates)
        return {'sorted_candidates': candidates}

    def __make_cache(self, context):
        for filename in self.__get_dictionaries(context):
            mtime = getmtime(filename)
            if filename in self.__cache and self.__cache[
                    filename].mtime == mtime:
                continue
            with open(filename, 'r', errors='replace') as f:
                self.__cache[filename] = DictCacheItem(
                        mtime, [{'word': x.split('\t')[0], 'kind': x.split('\t')[1]}
                            for x in sorted([x.strip() for x in f], key=str.lower)
                                if len(x.split('\t')) > 1]
                )

    def __get_dictionaries(self, context):
        return [dirname(realpath(__file__)) + "/lqs_table.csv"]
