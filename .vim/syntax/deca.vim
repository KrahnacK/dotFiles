" Vim syntax file
" Language:     Deca
" Maintainer:   LEPERS Baptiste

" Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  " we define it here so that included files can test for it
  let main_syntax='deca'
endif

" some characters that cannot be in a deca program (outside a string)
syn match decaError "[\\@`]"
syn match decaError "<<<\|\.\.\|=>\|<>\|||=\|&&=\|[^-]->\|\*\/"
syn match decaOK "\.\.\."

" use separate name so that it can be deleted in decacc.vim
syn match   decaError2 "#\|=<"
JavaHiLink decaError2 decaError



" keyword definitions
syn keyword decaExternal	native package
syn match decaExternal		"\<import\>\(\s\+static\>\)\?"
syn keyword decaError		goto const
syn keyword decaConditional	if else switch
syn keyword decaRepeat		while for do
syn keyword decaBoolean		true false
syn keyword decaConstant	null
syn keyword decaTypedef		this super
syn keyword decaOperator	new instanceof
syn keyword decaType		boolean char byte short int long float double
syn keyword decaType		void
syn keyword decaStatement	return
syn keyword decaStorageClass	static synchronized transient volatile final strictfp serializable
syn keyword decaExceptions	throw try catch finally
syn keyword decaAssert		assert
syn keyword decaMethodDecl	synchronized throws
syn keyword decaClassDecl	extends implements interface
" to differentiate the keyword class from MyClass.class we use a match here
syn match   decaTypedef		"\.\s*\<class\>"ms=s+1
syn keyword decaClassDecl	enum
syn match   decaClassDecl	"^class\>"
syn match   decaClassDecl	"[^.]\s*\<class\>"ms=s+1
syn match   decaAnnotation      "@[_$a-zA-Z][_$a-zA-Z0-9_]*\>"
syn match   decaClassDecl       "@interface\>"
syn keyword decaBranch		break continue nextgroup=decaUserLabelRef skipwhite
syn match   decaUserLabelRef	"\k\+" contained
syn match   decaVarArg		"\.\.\."
syn keyword decaScopeDecl	public protected private abstract

if exists("deca_highlight_deca_lang_ids")
  let deca_highlight_all=1
endif
if exists("deca_highlight_all")  || exists("deca_highlight_deca")  || exists("deca_highlight_deca_lang")
  " deca.lang.*
  syn match decaLangClass "\<System\>"
  syn keyword decaR_decaLang NegativeArraySizeException ArrayStoreException IllegalStateException RuntimeException IndexOutOfBoundsException UnsupportedOperationException ArrayIndexOutOfBoundsException ArithmeticException ClassCastException EnumConstantNotPresentException StringIndexOutOfBoundsException IllegalArgumentException IllegalMonitorStateException IllegalThreadStateException NumberFormatException NullPointerException TypeNotPresentException SecurityException
  syn cluster decaTop add=decaR_decaLang
  syn cluster decaClasses add=decaR_decaLang
  JavaHiLink decaR_decaLang decaR_deca
  syn keyword decaC_decaLang Process RuntimePermission StringKeySet CharacterData01 Class ThreadLocal ThreadLocalMap CharacterData0E Package Character StringCoding Long ProcessImpl ProcessEnvironment Short AssertionStatusDirectives 1PackageInfoProxy UnicodeBlock InheritableThreadLocal AbstractStringBuilder StringEnvironment ClassLoader ConditionalSpecialCasing CharacterDataPrivateUse StringBuffer StringDecoder Entry StringEntry WrappedHook StringBuilder StrictMath State ThreadGroup Runtime CharacterData02 MethodArray Object CharacterDataUndefined Integer Gate Boolean Enum Variable Subset StringEncoder Void Terminator CharsetSD IntegerCache CharacterCache Byte CharsetSE Thread SystemClassLoaderAction CharacterDataLatin1 StringValues StackTraceElement Shutdown ShortCache String ConverterSD ByteCache Lock EnclosingMethodInfo Math Float Value Double SecurityManager LongCache ProcessBuilder StringEntrySet Compiler Number UNIXProcess ConverterSE ExternalData CaseInsensitiveComparator CharacterData00 NativeLibrary
  syn cluster decaTop add=decaC_decaLang
  syn cluster decaClasses add=decaC_decaLang
  JavaHiLink decaC_decaLang decaC_deca
  syn keyword decaE_decaLang IncompatibleClassChangeError InternalError UnknownError ClassCircularityError AssertionError ThreadDeath IllegalAccessError NoClassDefFoundError ClassFormatError UnsupportedClassVersionError NoSuchFieldError VerifyError ExceptionInInitializerError InstantiationError LinkageError NoSuchMethodError Error UnsatisfiedLinkError StackOverflowError AbstractMethodError VirtualMachineError OutOfMemoryError
  syn cluster decaTop add=decaE_decaLang
  syn cluster decaClasses add=decaE_decaLang
  JavaHiLink decaE_decaLang decaE_deca
  syn keyword decaX_decaLang CloneNotSupportedException Exception NoSuchMethodException IllegalAccessException NoSuchFieldException Throwable InterruptedException ClassNotFoundException InstantiationException
  syn cluster decaTop add=decaX_decaLang
  syn cluster decaClasses add=decaX_decaLang
  JavaHiLink decaX_decaLang decaX_deca

  JavaHiLink decaR_deca decaR_
  JavaHiLink decaC_deca decaC_
  JavaHiLink decaE_deca decaE_
  JavaHiLink decaX_deca decaX_
  JavaHiLink decaX_		     decaExceptions
  JavaHiLink decaR_		     decaExceptions
  JavaHiLink decaE_		     decaExceptions
  JavaHiLink decaC_		     decaConstant

  syn keyword decaLangObject clone equals finalize getClass hashCode
  syn keyword decaLangObject notify notifyAll toString wait
  JavaHiLink decaLangObject		     decaConstant
  syn cluster decaTop add=decaLangObject
endif

if filereadable(expand("<sfile>:p:h")."/decaid.vim")
  source <sfile>:p:h/decaid.vim
endif

if exists("deca_space_errors")
  if !exists("deca_no_trail_space_error")
    syn match   decaSpaceError  "\s\+$"
  endif
  if !exists("deca_no_tab_space_error")
    syn match   decaSpaceError  " \+\t"me=e-1
  endif
endif

syn region  decaLabelRegion     transparent matchgroup=decaLabel start="\<case\>" matchgroup=NONE end=":" contains=decaNumber,decaCharacter
syn match   decaUserLabel       "^\s*[_$a-zA-Z][_$a-zA-Z0-9_]*\s*:"he=e-1 contains=decaLabel
syn keyword decaLabel		default

if !exists("deca_allow_cpp_keywords")
  " The default used to be to highlight C++ keywords.  But several people
  " don't like that, so default to not highlighting these.
  let deca_allow_cpp_keywords = 1
endif
if !deca_allow_cpp_keywords
  syn keyword decaError auto delete extern friend inline redeclared
  syn keyword decaError register signed sizeof struct template typedef union
  syn keyword decaError unsigned operator
endif

" The following cluster contains all deca groups except the contained ones
syn cluster decaTop add=decaExternal,decaError,decaError,decaBranch,decaLabelRegion,decaLabel,decaConditional,decaRepeat,decaBoolean,decaConstant,decaTypedef,decaOperator,decaType,decaType,decaStatement,decaStorageClass,decaAssert,decaExceptions,decaMethodDecl,decaClassDecl,decaClassDecl,decaClassDecl,decaScopeDecl,decaError,decaError2,decaUserLabel,decaLangObject,decaAnnotation,decaVarArg


" Comments
syn keyword decaTodo		 contained TODO FIXME XXX
if exists("deca_comment_strings")
  syn region  decaCommentString    contained start=+"+ end=+"+ end=+$+ end=+\*/+me=s-1,he=s-1 contains=decaSpecial,decaCommentStar,decaSpecialChar,@Spell
  syn region  decaComment2String   contained start=+"+  end=+$\|"+  contains=decaSpecial,decaSpecialChar,@Spell
  syn match   decaCommentCharacter contained "'\\[^']\{1,6\}'" contains=decaSpecialChar
  syn match   decaCommentCharacter contained "'\\''" contains=decaSpecialChar
  syn match   decaCommentCharacter contained "'[^\\]'"
  syn cluster decaCommentSpecial add=decaCommentString,decaCommentCharacter,decaNumber
  syn cluster decaCommentSpecial2 add=decaComment2String,decaCommentCharacter,decaNumber
endif
syn region  decaComment		 start="/\*"  end="\*/" contains=@decaCommentSpecial,decaTodo,@Spell
syn match   decaCommentStar      contained "^\s*\*[^/]"me=e-1
syn match   decaCommentStar      contained "^\s*\*$"
syn match   decaLineComment      "//.*" contains=@decaCommentSpecial2,decaTodo,@Spell
JavaHiLink decaCommentString decaString
JavaHiLink decaComment2String decaString
JavaHiLink decaCommentCharacter decaCharacter

syn cluster decaTop add=decaComment,decaLineComment

if !exists("deca_ignore_decadoc") && main_syntax != 'jsp'
  syntax case ignore
  " syntax coloring for decadoc comments (HTML)
  syntax include @decaHtml <sfile>:p:h/html.vim
  unlet b:current_syntax
  syn region  decaDocComment    start="/\*\*"  end="\*/" keepend contains=decaCommentTitle,@decaHtml,decaDocTags,decaDocSeeTag,decaTodo,@Spell
  syn region  decaCommentTitle  contained matchgroup=decaDocComment start="/\*\*"   matchgroup=decaCommentTitle keepend end="\.$" end="\.[ \t\r<&]"me=e-1 end="[^{]@"me=s-2,he=s-1 end="\*/"me=s-1,he=s-1 contains=@decaHtml,decaCommentStar,decaTodo,@Spell,decaDocTags,decaDocSeeTag

  syn region decaDocTags         contained start="{@\(link\|linkplain\|inherit[Dd]oc\|doc[rR]oot\|value\)" end="}"
  syn match  decaDocTags         contained "@\(param\|exception\|throws\|since\)\s\+\S\+" contains=decaDocParam
  syn match  decaDocParam        contained "\s\S\+"
  syn match  decaDocTags         contained "@\(version\|author\|return\|deprecated\|serial\|serialField\|serialData\)\>"
  syn region decaDocSeeTag       contained matchgroup=decaDocTags start="@see\s\+" matchgroup=NONE end="\_."re=e-1 contains=decaDocSeeTagParam
  syn match  decaDocSeeTagParam  contained @"\_[^"]\+"\|<a\s\+\_.\{-}</a>\|\(\k\|\.\)*\(#\k\+\((\_[^)]\+)\)\=\)\=@ extend
  syntax case match
endif

" match the special comment /**/
syn match   decaComment		 "/\*\*/"

" Strings and constants
syn match   decaSpecialError     contained "\\."
syn match   decaSpecialCharError contained "[^']"
syn match   decaSpecialChar      contained "\\\([4-9]\d\|[0-3]\d\d\|[\"\\'ntbrf]\|u\x\{4\}\)"
syn region  decaString		start=+"+ end=+"+ end=+$+ contains=decaSpecialChar,decaSpecialError,@Spell
" next line disabled, it can cause a crash for a long line
"syn match   decaStringError	  +"\([^"\\]\|\\.\)*$+
syn match   decaCharacter	 "'[^']*'" contains=decaSpecialChar,decaSpecialCharError
syn match   decaCharacter	 "'\\''" contains=decaSpecialChar
syn match   decaCharacter	 "'[^\\]'"
syn match   decaNumber		 "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
syn match   decaNumber		 "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match   decaNumber		 "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match   decaNumber		 "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"

" unicode characters
syn match   decaSpecial "\\u\d\{4\}"

syn cluster decaTop add=decaString,decaCharacter,decaNumber,decaSpecial,decaStringError

if exists("deca_highlight_functions")
  if deca_highlight_functions == "indent"
    syn match  decaFuncDef "^\(\t\| \{8\}\)[_$a-zA-Z][_$a-zA-Z0-9_. \[\]]*([^-+*/()]*)" contains=decaScopeDecl,decaType,decaStorageClass,@decaClasses
    syn region decaFuncDef start=+^\(\t\| \{8\}\)[$_a-zA-Z][$_a-zA-Z0-9_. \[\]]*([^-+*/()]*,\s*+ end=+)+ contains=decaScopeDecl,decaType,decaStorageClass,@decaClasses
    syn match  decaFuncDef "^  [$_a-zA-Z][$_a-zA-Z0-9_. \[\]]*([^-+*/()]*)" contains=decaScopeDecl,decaType,decaStorageClass,@decaClasses
    syn region decaFuncDef start=+^  [$_a-zA-Z][$_a-zA-Z0-9_. \[\]]*([^-+*/()]*,\s*+ end=+)+ contains=decaScopeDecl,decaType,decaStorageClass,@decaClasses
  else
    " This line catches method declarations at any indentation>0, but it assumes
    " two things:
    "   1. class names are always capitalized (ie: Button)
    "   2. method names are never capitalized (except constructors, of course)
    syn region decaFuncDef start=+^\s\+\(\(public\|protected\|private\|static\|abstract\|final\|native\|synchronized\)\s\+\)*\(\(void\|boolean\|char\|byte\|short\|int\|long\|float\|double\|\([A-Za-z_][A-Za-z0-9_$]*\.\)*[A-Z][A-Za-z0-9_$]*\)\(<[^>]*>\)\=\(\[\]\)*\s\+[a-z][A-Za-z0-9_$]*\|[A-Z][A-Za-z0-9_$]*\)\s*([^0-9]+ end=+)+ contains=decaScopeDecl,decaType,decaStorageClass,decaComment,decaLineComment,@decaClasses
  endif
  syn match  decaBraces  "[{}]"
  syn cluster decaTop add=decaFuncDef,decaBraces
endif

if exists("deca_highlight_debug")

  " Strings and constants
  syn match   decaDebugSpecial		contained "\\\d\d\d\|\\."
  syn region  decaDebugString		contained start=+"+  end=+"+  contains=decaDebugSpecial
  syn match   decaDebugStringError      +"\([^"\\]\|\\.\)*$+
  syn match   decaDebugCharacter	contained "'[^\\]'"
  syn match   decaDebugSpecialCharacter contained "'\\.'"
  syn match   decaDebugSpecialCharacter contained "'\\''"
  syn match   decaDebugNumber		contained "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
  syn match   decaDebugNumber		contained "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
  syn match   decaDebugNumber		contained "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
  syn match   decaDebugNumber		contained "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"
  syn keyword decaDebugBoolean		contained true false
  syn keyword decaDebugType		contained null this super
  syn region decaDebugParen  start=+(+ end=+)+ contained contains=decaDebug.*,decaDebugParen

  " to make this work you must define the highlighting for these groups
  syn match decaDebug "\<System\.\(out\|err\)\.print\(ln\)*\s*("me=e-1 contains=decaDebug.* nextgroup=decaDebugParen
  syn match decaDebug "\<p\s*("me=e-1 contains=decaDebug.* nextgroup=decaDebugParen
  syn match decaDebug "[A-Za-z][a-zA-Z0-9_]*\.printStackTrace\s*("me=e-1 contains=decaDebug.* nextgroup=decaDebugParen
  syn match decaDebug "\<trace[SL]\=\s*("me=e-1 contains=decaDebug.* nextgroup=decaDebugParen

  syn cluster decaTop add=decaDebug

  if version >= 508 || !exists("did_c_syn_inits")
    JavaHiLink decaDebug		 Debug
    JavaHiLink decaDebugString		 DebugString
    JavaHiLink decaDebugStringError	 decaError
    JavaHiLink decaDebugType		 DebugType
    JavaHiLink decaDebugBoolean		 DebugBoolean
    JavaHiLink decaDebugNumber		 Debug
    JavaHiLink decaDebugSpecial		 DebugSpecial
    JavaHiLink decaDebugSpecialCharacter DebugSpecial
    JavaHiLink decaDebugCharacter	 DebugString
    JavaHiLink decaDebugParen		 Debug

    JavaHiLink DebugString		 String
    JavaHiLink DebugSpecial		 Special
    JavaHiLink DebugBoolean		 Boolean
    JavaHiLink DebugType		 Type
  endif
endif

if exists("deca_mark_braces_in_parens_as_errors")
  syn match decaInParen		 contained "[{}]"
  JavaHiLink decaInParen	decaError
  syn cluster decaTop add=decaInParen
endif

" catch errors caused by wrong parenthesis
syn region  decaParenT  transparent matchgroup=decaParen  start="("  end=")" contains=@decaTop,decaParenT1
syn region  decaParenT1 transparent matchgroup=decaParen1 start="(" end=")" contains=@decaTop,decaParenT2 contained
syn region  decaParenT2 transparent matchgroup=decaParen2 start="(" end=")" contains=@decaTop,decaParenT  contained
syn match   decaParenError       ")"
" catch errors caused by wrong square parenthesis
syn region  decaParenT  transparent matchgroup=decaParen  start="\["  end="\]" contains=@decaTop,decaParenT1
syn region  decaParenT1 transparent matchgroup=decaParen1 start="\[" end="\]" contains=@decaTop,decaParenT2 contained
syn region  decaParenT2 transparent matchgroup=decaParen2 start="\[" end="\]" contains=@decaTop,decaParenT  contained
syn match   decaParenError       "\]"

JavaHiLink decaParenError       decaError

if !exists("deca_minlines")
  let deca_minlines = 10
endif
exec "syn sync ccomment decaComment minlines=" . deca_minlines

" The default highlighting.
if version >= 508 || !exists("did_deca_syn_inits")
  if version < 508
    let did_deca_syn_inits = 1
  endif
  JavaHiLink decaFuncDef		Function
  JavaHiLink decaVarArg                 Function
  JavaHiLink decaBraces			Function
  JavaHiLink decaBranch			Conditional
  JavaHiLink decaUserLabelRef		decaUserLabel
  JavaHiLink decaLabel			Label
  JavaHiLink decaUserLabel		Label
  JavaHiLink decaConditional		Conditional
  JavaHiLink decaRepeat			Repeat
  JavaHiLink decaExceptions		Exception
  JavaHiLink decaAssert			Statement
  JavaHiLink decaStorageClass		StorageClass
  JavaHiLink decaMethodDecl		decaStorageClass
  JavaHiLink decaClassDecl		decaStorageClass
  JavaHiLink decaScopeDecl		decaStorageClass
  JavaHiLink decaBoolean		Boolean
  JavaHiLink decaSpecial		Special
  JavaHiLink decaSpecialError		Error
  JavaHiLink decaSpecialCharError	Error
  JavaHiLink decaString			String
  JavaHiLink decaCharacter		Character
  JavaHiLink decaSpecialChar		SpecialChar
  JavaHiLink decaNumber			Number
  JavaHiLink decaError			Error
  JavaHiLink decaStringError		Error
  JavaHiLink decaStatement		Statement
  JavaHiLink decaOperator		Operator
  JavaHiLink decaComment		Comment
  JavaHiLink decaDocComment		Comment
  JavaHiLink decaLineComment		Comment
  JavaHiLink decaConstant		Constant
  JavaHiLink decaTypedef		Typedef
  JavaHiLink decaTodo			Todo
  JavaHiLink decaAnnotation             PreProc

  JavaHiLink decaCommentTitle		SpecialComment
  JavaHiLink decaDocTags		Special
  JavaHiLink decaDocParam		Function
  JavaHiLink decaDocSeeTagParam		Function
  JavaHiLink decaCommentStar		decaComment

  JavaHiLink decaType			Type
  JavaHiLink decaExternal		Include

  JavaHiLink htmlComment		Special
  JavaHiLink htmlCommentPart		Special
  JavaHiLink decaSpaceError		Error
endif

delcommand JavaHiLink

let b:current_syntax = "deca"

if main_syntax == 'deca'
  unlet main_syntax
endif

let b:spell_options="contained"

" vim: ts=8
