
module.exports = (grunt) ->
  
  # Configuration
  # ---------------------------------------------------------------------------
  app_dir = 'client'
  build_dir = 'public'
  # initialize grunt config with created config
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    # clean
    clean:
      minify: "js-opt"

    # less
    less:
      release:
        options:
          yuicompress: true
        files:
          "public/css/main.css":  "client/less/main.less"

    # coffee compilation tasks
    coffee:
      app:
        files:[
          expand: true
          bare: true
          cwd: app_dir + '/coffee/'
          src: ['**/*.coffee']
          dest: build_dir + '/js/'
          ext: '.js'
        ]
        
    requirejs:
      compile: 
        options:
          appDir: "public/js"
          baseUrl: "."
          dir: "js-opt"
          mainConfigFile: "public/js/main.js"
          modules:[
            name: "main"
          ]

    copy:

      vendor:
        files:[
          cwd:  app_dir + '/vendors/' 
          expand: true
          src: ['**']
          dest: build_dir + '/js/vendors/'
        ]
      templates:
        files:[
          cwd:  app_dir + '/templates/' 
          expand: true
          src: ['**']
          dest: build_dir + '/templates/'
        ]
      assets:
        files:[
          cwd:  app_dir + '/img/' 
          expand: true
          src: ['**']
          dest: build_dir + '/img/'
        ]
      minify:
        files: [
          cwd: 'js-opt/' 
          expand: true
          src: ['main.js']
          dest: build_dir + '/js/'
        ]


    # watch for changes in single directories and compile or copy parts of the
    # sources (much faster than always performing a complete build)
    watch:

      coffee:
        files: app_dir + '/**/*.coffee'
        tasks: 'coffee:app'

      fixtures:
        files: app_dir + '/test/fixtures/**'
        tasks: 'copy:fixtures'
      
    # task to generate config file for client and index.html
    

  
   # Load grunt tasks
  # ---------------------------------------------------------------------------
  
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-requirejs'
  
  # Task Collections
  # ---------------------------------------------------------------------------

  # // Register default task
  grunt.registerTask 'set_global', 'Set a global variable.', (name, val)->
    global[name] = val;


  grunt.registerTask 'default', ['watch']
  grunt.registerTask 'build', ['coffee', 'copy', 'less']
  grunt.registerTask 'build:prod', ['coffee', 'copy', 'requirejs', 'copy:minify', 'clean:minify', 'less']
  # Test Tasks
