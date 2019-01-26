import unittest
import base

class Suite(base.Base):
    def test_1(self):
        """Test case 1"""
        self.start("scrollTopLeft.html")
        self.fail_errors()
