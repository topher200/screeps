= Topher's Screeps =

CoffeeScript based controller for MMO RTS screeps.com.


== Running the Code ==

Use grunt to generate a monolithic JavaScript controller file.

 - run 'npm install' to install dependences
 - Compile with 'grunt'
  - (optional): Set a behavior mode with 'grunt --mode pacifist'. Defaults
    to "default_mode".
 - Use copy_to_clipboard.bat to copy the generated .js file. Paste it into the
   web app.
   - This will be modified when the servers are up and running, but right now
     the only place to play with the screeps is in the online sandbox.


== Current Features ==

Still in the beginning phases of experimenting, nothing is fleshed out.

 - Spawns and controls harvesters, short-range warriors, and healers
 - Memory garbage collector
