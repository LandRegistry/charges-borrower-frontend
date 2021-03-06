from tests.helpers import with_client, setUpApp, with_context
from unittest import TestCase


class TestViewDeed(TestCase):
    def setUp(self):
        setUpApp(self)

    @with_context
    @with_client
    def test_view_deed_get(self, client):
        res = client.get('/deed/view')

        self.assertEqual(res.status_code, 200)
