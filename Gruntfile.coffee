
module.exports = (grunt) ->
  
  # Configuration
  # ---------------------------------------------------------------------------
  app_dir = 'client'
  build_dir = 'public'
  # never give the same name to build_dir and tmp_dir
  tmp_dir = 'tmp'
  # initialize grunt config with created config
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    clean:
      minify: tmp_dir
      public: "public"
      sass: ".sass-cache"

    less:
      release:
        options:
          yuicompress: true
          compress: true
        files:
          "public/css/main.css":  "client/less/main.less"

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
      helper:
        files:[
          expand: true
          bare: true
          cwd: app_dir + '/template/helpers'
          src: ['**/*.coffee']
          dest: build_dir + '/template/helpers'
          ext: '.js'
        ]
        
    requirejs:
      compile: 
        options:
          appDir: "public/js"
          baseUrl: "."
          dir: tmp_dir
          mainConfigFile: "public/js/main.js"
          optimize: "uglify2"
          inlineText: true
          uglify2:
            compress:
              dead_code: true
              properties: true
              loops: true
              warnings: true
          preserveLicenseComments: false
          modules:[
            name: "main"
          ]
    compass: 
      prod: 
        options:
          sassDir: app_dir + '/sass/'
          cssDir: build_dir + '/css/'
          imagesPath: app_dir 
          imagesDir: ""
          # clean: true
          importPath: app_dir
          environment: "production"
          relativeAssets: false
          generatedImagesPath: build_dir

      dev:
        options:
          sassDir: app_dir + '/sass/'
          cssDir: build_dir + '/css/'
          imagesPath: app_dir 
          imagesDir: ""
          importPath: app_dir
          relativeAssets: false
          generatedImagesPath: build_dir

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
          cwd:  app_dir + '/template/' 
          expand: true
          src: ['**/*.hbs']
          dest: build_dir + '/template/'
        ]
      assets:
        files:[
          cwd:  app_dir + '/img/' 
          expand: true
          src: ['**']
          dest: build_dir + '/img/'
        ]
      data:
        files:[
          cwd:  app_dir + '/data/' 
          expand: true
          src: ['**']
          dest: build_dir + '/js/data/'
        ]
      minify:
        files: [
          cwd: tmp_dir 
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
        files: app_dir + '/template/fixtures/**'
        tasks: 'copy:fixtures'
  
   # Load grunt tasks
  # ---------------------------------------------------------------------------
  
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-contrib-compass' 
  # // Register default task
  grunt.registerTask 'set_global', 'Set a global variable.', (name, val)->
    global[name] = val;


  grunt.registerTask 'default', ['watch']
  grunt.registerTask 'build', ['clean','coffee', 'copy', 'less']
  grunt.registerTask 'build:prod', ['build','requirejs', 'copy:minify', 'clean:minify', 'compass:prod', 'clean:sass']
  # Test Tasks
