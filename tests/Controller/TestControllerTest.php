<?php

namespace App\Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class TestControllerTest extends WebTestCase
{
    public function testSomething(): void
    {
        $client = static::createClient();
        $crawler = $client->request('GET', '/');

        $this->assertResponseStatusCodeSame(404);
    }
}
