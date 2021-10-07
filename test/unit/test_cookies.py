# -*- coding: utf-8 -*-
# --------------------------
# Copyright © 2014 -            Qentinel Group.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ---------------------------

from QWeb.internal import cookies
from unittest.mock import patch
from selenium.common.exceptions import NoSuchWindowException
import pytest


class Corona:

    @staticmethod
    def get_cookies():
        return '123'


@patch('QWeb.internal.browser.get_current_browser')
def test_delete_all_cookies(patched_browser):
    patched_browser.return_value = None
    with pytest.raises(NoSuchWindowException):
        cookies.delete_all_cookies()


@patch('QWeb.internal.browser.get_current_browser')
def test_get_cookies_fail(patched_browser):
    patched_browser.return_value = None
    with pytest.raises(NoSuchWindowException):
        cookies.get_cookies()
