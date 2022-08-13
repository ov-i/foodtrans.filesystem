<?php

$finder = PhpCsFixer\Finder::create()
  ->in(__DIR__)
  ->exclude('vendor', 'tests', 'tools');

$config = new PhpCsFixer\Config();
return $config
        ->setRules([
          '@PSR12' => true,
          'clean_namespace' => true,
          'fully_qualified_strict_types' => true,
          'blank_line_after_namespace' => true,
          'blank_line_after_opening_tag' => true,
          'full_opening_tag' => true,
          'no_closing_tag' => true,
          'method_argument_space' => true,
          'magic_method_casing' => true,
          'no_empty_statement' => true,
        ])
        ->setFinder($finder);