" Annotations
syn match scalaAnnotation "@[A-Z][a-z]\+"

" Hilighting
hi! Tag							guifg=#056ca2 gui=bold

hi link scalaAnnotation Special
hi! link scalaDefSpecializer Special
" Hiligthing XML
hi! link scalaXml String
hi! link scalaXmlTag Tag
hi! link scalaXmlString String
hi! link scalaXmlStart Tag
hi! link scalaXmlEscape Normal
hi! link scalaXmlEscapeSpecial Special
hi! link scalaXmlQuote Special
hi! link scalaXmlComment Comment
