ExtendedScene.prototype = Object.create(Scene.prototype);
ExtendedScene.prototype.constructor = ExtendedScene;
function ExtendedScene()
{
    Scene.call(this);
}
ExtendedScene.prototype.showDisplay = function ()
{
    var circle = new createjs.Shape();
    circle.graphics.beginFill(this.getColorByIndex(this.m_index));
    circle.graphics.drawCircle(70,30,30);
    this.m_container.addChild(circle);
};
ExtendedScene.prototype.getColorByIndex = function (id)
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
    //console.log("MyColor: ", returned, this.m_index, id);
    return returned;
};