ExtendedScene.prototype = Object.create(Scene.prototype);
ExtendedScene.prototype.constructor = ExtendedScene;
function ExtendedScene()
{
    Scene.call(this);
}
ExtendedScene.prototype.showDisplay = function ()
{
    var circle = new createjs.Shape();
    circle.graphics.beginFill(this.getColorById(this.id));
    circle.graphics.drawCircle(50,50,30);
    this.m_container.addChild(circle);
};
ExtendedScene.prototype.getColorById = function (id)
{
    var returned ="";
    switch (id)
    {
        case 0:
            returned = "green";
            break;
        case 1:
            returned = "blue";
            break;
        case 2:
            returned = "red";
            break;
        case 3:
            returned = "yellow";
            break;
        case 4:
            returned = "orange";
            break;
        case 5:
            returned = "gray";
            break;
        case 6:
            returned = "pink";
            break;
    }
    //console.log("MyColor: ", returned, this.id, id);
    return returned;
};