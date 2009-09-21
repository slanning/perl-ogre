MODULE = Ogre     PACKAGE = Ogre::SceneNode

# SceneNode * createChildSceneNode(const Vector3 &translate=Vector3::ZERO, const Quaternion &rotate=Quaternion::IDENTITY)
# SceneNode * createChildSceneNode(const String &name, const Vector3 &translate=Vector3::ZERO, const Quaternion &rotate=Quaternion::IDENTITY)
SceneNode *
SceneNode::createChildSceneNode(...)
  CODE:
    // Alrighty then, here we go...

    // 0 args passed, must not be 2nd version, so pass no args
    if (items == 1) {
        RETVAL = THIS->createChildSceneNode();
    }
    else {
        // 1st arg is Vector3
        if (sv_isobject(ST(1)) && sv_derived_from(ST(1), "Ogre::Vector3")) {
            Vector3 *vec = (Vector3 *) SvIV((SV *) SvRV(ST(1)));   // TMOGRE_IN

            // 1 arg passed
            if (items == 2) {
                RETVAL = THIS->createChildSceneNode(*vec);
            }
            // 2 args passed
            else if (items == 3) {
                if (sv_isobject(ST(2)) && sv_derived_from(ST(2), "Ogre::Quaternion")) {
                    Quaternion *q = (Quaternion *) SvIV((SV *) SvRV(ST(2)));  // TMOGRE_IN

                    RETVAL = THIS->createChildSceneNode(*vec, *q);
                }
                else {
                  croak("Usage: Ogre::SceneNode::createChildSceneNode(THIS, Vector3, Quaternion)\n");
                }
            }
        }
        // 1st arg is String
        else {
            char * xstmpchr = (char *) SvPV_nolen(ST(1));
            String name = xstmpchr;

            // 1 arg passed
            if (items == 2) {
                RETVAL = THIS->createChildSceneNode(name);
            }
            // 2 args passed
            else if (items == 3) {
                if (sv_isobject(ST(2)) && sv_derived_from(ST(2), "Ogre::Vector3")) {
                    Vector3 *vec = (Vector3 *) SvIV((SV *) SvRV(ST(2)));     // TMOGRE_IN

                    RETVAL = THIS->createChildSceneNode(name, *vec);
                }
                else {
                  croak("Usage: Ogre::SceneNode::createChildSceneNode(THIS, String, Vector3)\n");
                }
            }
            // 3 args passed
            else if (items == 4) {
                if (sv_isobject(ST(2)) && sv_derived_from(ST(2), "Ogre::Vector3")) {
                    Vector3 *vec = (Vector3 *) SvIV((SV *) SvRV(ST(2)));     // TMOGRE_IN

                    if (sv_isobject(ST(3)) && sv_derived_from(ST(3), "Ogre::Quaternion")) {
                        Quaternion *q = (Quaternion *) SvIV((SV *) SvRV(ST(3)));  // TMOGRE_IN

                        RETVAL = THIS->createChildSceneNode(name, *vec, *q);
                    }
                    else {
                      croak("Usage: Ogre::SceneNode::createChildSceneNode(THIS, String, Vector3, Quaternion)\n");
                    }
                }
                else {
                  croak("Usage: Ogre::SceneNode::createChildSceneNode(THIS, String, Vector3, Quaternion)\n");
                }
            }
        }

    }
  OUTPUT:
    RETVAL

void
SceneNode::attachObject(obj)
    MovableObject * obj

void
SceneNode::detachObject(obj)
    MovableObject * obj

SceneNode *
SceneNode::getParentSceneNode()

unsigned short
SceneNode::numAttachedObjects()

# ...

void
SceneNode::detachAllObjects()

void
SceneNode::removeAndDestroyAllChildren()

bool
SceneNode::isInSceneGraph()

SceneManager *
SceneNode::getCreator()

void
SceneNode::showBoundingBox(bShow)
    bool  bShow

bool
SceneNode::getShowBoundingBox()

void
SceneNode::setFixedYawAxis(useFixed, fixedAxis)
    bool  useFixed
    Vector3 * fixedAxis
  C_ARGS:
    useFixed, *fixedAxis

void
SceneNode::setDirection(x, y, z, relativeTo, localDirectionVector)
    Real  x
    Real  y
    Real  z
    int    relativeTo
    Vector3 * localDirectionVector
  C_ARGS:
    x, y, z, (Ogre::Node::TransformSpace)relativeTo, *localDirectionVector

void
SceneNode::lookAt(targetPoint, relativeTo, localDirectionVector)
    Vector3 * targetPoint
    int    relativeTo
    Vector3 * localDirectionVector
  C_ARGS:
    *targetPoint, (Ogre::Node::TransformSpace)relativeTo, *localDirectionVector

void
SceneNode::setAutoTracking(enabled, target, localDirectionVector, offset)
    bool        enabled
    SceneNode * target
    Vector3 *   localDirectionVector
    Vector3 *   offset
  C_ARGS:
    enabled, target, *localDirectionVector, *offset

SceneNode *
SceneNode::getAutoTrackTarget()
