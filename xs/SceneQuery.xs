MODULE = Ogre     PACKAGE = Ogre::SceneQuery

void
SceneQuery::setQueryMask(uint32 mask)

uint32
SceneQuery::getQueryMask()

void
SceneQuery::setQueryTypeMask(uint32 mask)

uint32
SceneQuery::getQueryTypeMask()

void
SceneQuery::setWorldFragmentType(int wft)
  C_ARGS:
    (SceneQuery::WorldFragmentType)wft

int
SceneQuery::getWorldFragmentType()

## const std::set< WorldFragmentType > * SceneQuery::getSupportedWorldFragmentTypes()
## note: this just returns a list
void
SceneQuery::getSupportedWorldFragmentTypes()
  PPCODE:
    const std::set<SceneQuery::WorldFragmentType> *wfts = THIS->getSupportedWorldFragmentTypes();
    std::set<SceneQuery::WorldFragmentType>::const_iterator it;
    for (it = wfts->begin(); it != wfts->end(); it++) {
        mXPUSHi((int) *it);
    }
