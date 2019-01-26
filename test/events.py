import unittest
import base

class Suite(base.Base):
    def test_1(self):
        """Test case 1"""
        self.start("events.html")
        el = self.xpath('button[1]')
        el.click()
        alert = self.driver.switch_to.alert
        self.assertEqual("hi", alert.text)
        alert.accept()
        self.fail_errors()
    def test_2(self):
        """Test case 2"""
        self.start("events.html")
        txt = self.xpath('div/span')
        inc = self.xpath('div/button[1]')
        dec = self.xpath('div/button[2]')
        self.assertEqual("0", txt.text)
        inc.click()
        self.assertEqual("1", txt.text)
        inc.click()
        inc.click()
        self.assertEqual("3", txt.text)
        dec.click()
        self.assertEqual("2", txt.text)
        self.fail_errors()
