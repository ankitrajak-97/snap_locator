Binding
    - app binding (define the services)
Service
    - permision service
        - onInit() onReady() => do not call them or do not write any function on those block
        - create separate functions to ask for permission
    - location service
        - onInit() onReady() => do not call them or do not write any function on those block
        - create separate function to fetch location
    - shard pref service
        - can call on onInit() or onReady()
    - database service
        - can call on onInit() or onReady()
UI
    - view
    - controller
        - Get.find<NameOfTheService>()
        - onFloatingActionClick()
            permissionService.requestForPermissions()
Alert
    THESE WILL BE A VIEW. WITHOUT ANY CONTROLLER.
    - Bottom Sheet
        - image capture or gallary image picker
    - Dialog
        - tell user about permisisons not granted
