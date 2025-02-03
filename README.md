# Nodoban
Nodoban is a node graph creator made in Godot. I originally made this tool as a utility for a personal project, but I figured
other people could find some use in it, so I made it available online, free and open-source.

With Nodoban, you can create and link nodes together, as well as make "node types" with custom properties, add property overwrites to existing nodes/links,
and save/load node graphs in a compact JSON file.

# Crash course

At first, you will see a gray canvas with a menu button and "[New file]" written at the top.

![The window right after you open it up](https://i.imgur.com/ZZr76Gt.png)

Let's create our first node. Right click on the empty canvas and click "Create new node".

![Context menu with a "Create new node" option](https://i.imgur.com/yWhxSpl.png)

There it is, your first node! But it's colored red. That means it's of an invalid type, i.e. there isn't such as a node type named "node".

![A node! But it's colored red?](https://i.imgur.com/Vs1cWWg.png)

So let's create a node type. Click on the button at the top left and select "Node types"

![Menu button context menu with a "Node types" option](https://i.imgur.com/JDRTuAJ.png)

A new window should pop up. Click on the "New node type" button.

![Node types window](https://i.imgur.com/EljObLn.png)

Let's give a name to our new node type.

![Naming our newly created node type](https://i.imgur.com/pxj4eQS.png)

Head back to the canvas, right click on your node and select "Set node type". Then click on the name of the node type you just created.

![Setting the node type for our node](https://i.imgur.com/mBClMtx.png)

Nice, we changed the type of our node! What else can we do?

![We set our node type!](https://i.imgur.com/iSJtkY2.png)

Let's create a link between nodes. Create a new node and set its type. Then click on one of the nodes and then "Create new link"

![Node context menu with a highlighted "Create new link" option](https://i.imgur.com/YCcUQOm.png)

Then click on the other node. This will create a link going from the first node to the second.

![An arrow from the first node to the arrow. Click on one of the nodes to finish the link](https://i.imgur.com/3nz0Gz4.png)

Great, there's your link between nodes! Now let's make a small example graph. I've created a few more node types, some more nodes and linked them together.

![Node graph example](https://i.imgur.com/nE2VfPf.png)

Let's save our chart to a file! Click on the menu button and then "Save file"

![Menu button context menu with a highlighted "Save file" optiion](https://i.imgur.com/LQRT5k4.png)

Set your file's name and destination folder. Here, it will be saved as "ExampleGraph.json"

![Saving a graph file](https://i.imgur.com/bdbW8jq.png)

Now the file is saved. It even changed the text at the top to the file's path!

![File saved!](https://i.imgur.com/DqT0TEE.png)

If you want to load a file previously saved, just click on the menu button > Load file and select your file.

![Loading a file](https://i.imgur.com/BmDNf4u.png)

Now if you look at the structure of our graph JSON file, you'll see that it contains all of our nodes, links and node types we have created.

![Graph file structure](https://i.imgur.com/KjLw66a.png)

However, one of the core features of this tool is that you can create "properties" for nodes and links you have created, and we haven't touched on that topic yet, so let's do it now.

Open up the Node types window and click on the "New property" button under one of the node types you have created.

![Creating a new property for a node type](https://i.imgur.com/YD0YGSF.png)

This will create a new property under our node type. Give it a name.

![Name your node type property](https://i.imgur.com/4b8hLxb.png)

You can also set the datatype for your property. You can pick either String, Number, Boolean, or an Array with various items of those four types inside. I'll pick an array for this one.

![Setting the property's datatype to array](https://i.imgur.com/vjSTToO.png)

Your node type should look something like this. Let's save the file and take a look inside.

![Finished setting node type property](https://i.imgur.com/rpJOQuo.png)

Our file now contains the properties we've set in the node types window, under the node type we defined!

![There it is, the node type properties we set](https://i.imgur.com/TgtjKcB.png)

You can also create property overwrites on specific nodes. Right click on one of the nodes and select "Add property overwrite"

![Adding a property overwrite](https://i.imgur.com/cuwaRte.png)

A property box will show up under the node's type name. Just set everything up like you did in the Node types window.

![Setting up a property overwrite](https://i.imgur.com/PSTxGvw.png)

Let's save the file and take a look. There you can see the overwrites added to the node. The idea is that, in your code, you read the properties of that node's type,
and then overwrite them with the properties you defined under the node itself.

![Node overwrites inside the file](https://i.imgur.com/bdxkm0D.png)

Finally, you can also create properties for links between nodes. Right click on one of the links and select "Add link property"

![Adding a link property](https://i.imgur.com/8fMbB47.png)

A property box will pop up over the link. There's nothing to it, set your properties just like you did before.

![Setting up link properties](https://i.imgur.com/vMJH733.png)

Mine looks like this. If we save and check the file inside...

![Added property to link](https://i.imgur.com/8PXiY8N.png)

...we can see the property we just added to our link!

![There's our link property!](https://i.imgur.com/VoA9sIH.png)

And that's pretty much it!
