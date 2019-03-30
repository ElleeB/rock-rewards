**Designed with consideration for object-oriented design,
and basic Ruby organization conventions.**

---

*.bin*
  contains two startup scripts
  - one to initiate an interactive console
  - one to execute the app's CLI

*.config*
  contains basic environment file for initiation
  - requires bundler
  - requires/points to all files in the .lib folder

*.lib*
  contains two model files, a cli controller, and an app module
  - client and customer model files manage their relative objects and instances
  - cli controller: contains all the code to run the CLI (called in .bin)
  - app module: manages id and secret_key assignments

*.spec*
  contains a single file with a test for each model

---

**Execution Instructions**

Install RVM
  * \curl -sSL https://get.rvm.io | bash
    [options here https://rvm.io/rvm/install]  

Install Ruby
---
* rvm install 2.6.3

Please navigate into the project folder and run:
---
* gem install bundler
* bundle install
* ruby ./bin/rocking_rewards (interactive CLI)
/// OR
* ruby './bin/demo.rb' (seeded, auto demo)
