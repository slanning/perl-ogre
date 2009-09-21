MODULE = Ogre     PACKAGE = Ogre::Renderable

Real
Renderable::getSquaredViewDepth(cam)
    Camera * cam

unsigned short
Renderable::getNumWorldTransforms()

bool
Renderable::getCastsShadows()

bool
Renderable::getPolygonModeOverrideable()

void
Renderable::setPolygonModeOverrideable(override)
    bool  override


#Quaternion *
#Renderable::getWorldOrientation()

#Vector3 *
#Renderable::getWorldPosition()

#Matrix4 *
#Renderable::getWorldTransforms()
