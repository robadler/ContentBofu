ContentBofu
=========
**What is ContentBofu?**

ContentBofu is basically a collaboration of tools that I've re-written or plan to re-write for use in my projects in Ruby/Rails. Most are based around content spinning/creation/etc.


**Does it require any other libraries/gems?**

If you're using the TheBestSpinner aspect of it, yes. I utilize mechanize and a gem called 'php-serialize'.


**What can it do?**

It can spin content using synonyms from TheBestSpinner, WordAI, and supports "superspin" or "nested spins"


**How do I get support?**

Hit me up on Twitter (@Bofu2U) and I'll try to help out any way I can.


**Example uses?**

Here's a few examples to get you started. The main 2 (and only 2) functions right now are TBS (TheBestSpinner) API and my madlib function (superspin/nested spin).

	# Evaluate spintax article

	require 'contentbofu'

	bofu = ContentBofu.new

	puts bofu.madlib("{I|You|We} Write {Content|Words|Sentences}")

	# I Write Content / We Write Sentences / We Write Words / You Write Sentences / etc.



And for TBS, make sure you set your settings before use.


	# Run a sentence through TBS

	require 'contentbofu'

	bofu = ContentBofu.new

	bofu.tbs_user = "email@address.com"

	bofu.tbs_pass = "secrets"

	puts bofu.tbs_spin("After finishing up on this code, I would like to get a reply with some other ways to phrase this sentence.")

	# {After|Following|Right after|Soon after|Immediately after|Just after|When|Once} finishing up on this code, I would like to get a reply with some other {ways|methods|techniques|approaches|strategies|tactics|means|options} to phrase this sentence.


For WordAI:

	# Run a sentence through WordAI

	require 'contentbofu'

	bofu = ContentBofu.new

	bofu.wai_user = "email@address.com"

	bofu.wai_pass = "secrets"

	bofu.wai_slider = "50"

	puts bofu.wai_spin("After finishing up on this code, I would like to get a reply with some other ways to phrase this sentence.")

	# After finishing {up on|through to} this {code|signal|rule}, {I would|I'd} {like to|prefer to|want to} get {a reply|a response|an answer} with {some other|various other} {ways to|methods to|approaches to} phrase this {sentence|word}.


Hit me up on Twitter (@Bofu2U) if you want to get in contact.

-Bofu2U
