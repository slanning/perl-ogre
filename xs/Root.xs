MODULE = Ogre     PACKAGE = Ogre::Root

static Root *
Root::getSingletonPtr()

Root *
Root::new(...)
  CODE:
    if (items == 1) {
        RETVAL = new Root();
    }
    else if (items == 2) {
	String pluginFileName((char *) SvPV_nolen(ST(1)));
        RETVAL = new Root(pluginFileName);
    }
    else if (items == 3) {
	String pluginFileName((char *) SvPV_nolen(ST(1)));
	String configFileName((char *) SvPV_nolen(ST(2)));
        RETVAL = new Root(pluginFileName, configFileName);
    }
    else if (items == 4) {
	String pluginFileName((char *) SvPV_nolen(ST(1)));
	String configFileName((char *) SvPV_nolen(ST(2)));
	String logFileName((char *) SvPV_nolen(ST(3)));
        RETVAL = new Root(pluginFileName, configFileName, logFileName);
    }
    else {
        croak("Usage: Ogre::Root::new(CLASS [, pluginFileName [, configFileName [, logFileName]]])\n");
    }
  OUTPUT:
    RETVAL

void
Root::DESTROY()

void
Root::saveConfig()

bool
Root::restoreConfig()

bool
Root::showConfigDialog()

void
Root::addRenderSystem(RenderSystem *newRend)

RenderSystem *
Root::getRenderSystemByName(String name)

void
Root::setRenderSystem(RenderSystem *system)

RenderSystem *
Root::getRenderSystem()

RenderWindow *
Root::initialise(autoCreateWindow, ...)
    bool    autoCreateWindow
  CODE:
    String windowTitle;
    if (items == 3) {
        char * xstmpchr = (char *) SvPV_nolen(ST(2));
        windowTitle = xstmpchr;
    }
    else {
        windowTitle = "OGRE Render Window";
    }
    RETVAL = THIS->initialise(autoCreateWindow, windowTitle);
  OUTPUT:
    RETVAL

bool
Root::isInitialised()

# addSceneManagerFactory, ...

## note: there are 2 variants of this in the C++ API
SceneManager *
Root::createSceneManager(...)
  CODE:
    String instanceName = StringUtil::BLANK;
    if (items == 3) {
        char * xstmpchr_iname = (char *) SvPV_nolen(ST(2));
        instanceName = xstmpchr_iname;
    }

    // SceneManager * createSceneManager (SceneTypeMask typeMask, const String &instanceName=StringUtil::BLANK)
    if (looks_like_number(ST(1))) {
        SceneTypeMask typeMask = (SceneTypeMask)SvUV(ST(1));

        RETVAL = THIS->createSceneManager(typeMask, instanceName);
    }
    // SceneManager * createSceneManager (const String &typeName, const String &instanceName=StringUtil::BLANK)
    else {
        char * xstmpchr_tname = (char *) SvPV_nolen(ST(1));
        String typeName = xstmpchr_tname;

        RETVAL = THIS->createSceneManager(typeName, instanceName);
    }
  OUTPUT:
    RETVAL


void
Root::destroySceneManager(sm)
    SceneManager * sm

SceneManager *
Root::getSceneManager(instanceName)
    String  instanceName

TextureManager *
Root::getTextureManager()

MeshManager *
Root::getMeshManager()

String
Root::getErrorDescription(errorNumber)
    long  errorNumber

## pass in Perl object of class implementing Ogre::FrameListener
void
Root::addFrameListener(perlListener)
    SV * perlListener
  CODE:
    pogreCallbackManager.addFrameListener(perlListener, THIS);

void
Root::removeFrameListener(perlListener)
    SV * perlListener
  CODE:
    pogreCallbackManager.removeFrameListener(perlListener, THIS);

void
Root::queueEndRendering()

void
Root::startRendering()

bool
Root::renderOneFrame()

void
Root::shutdown()

void
Root::addResourceLocation(String name, String locType, String groupName=ResourceGroupManager::DEFAULT_RESOURCE_GROUP_NAME, bool recursive=false)

RenderWindow *
Root::getAutoCreatedWindow()

# RenderWindow * createRenderWindow(const String &name, unsigned int width, unsigned int height, bool fullScreen, const NameValuePairList *miscParams=0)
RenderWindow *
Root::createRenderWindow(name, width, height, fullScreen, ...)
    String        name
    unsigned int  width
    unsigned int  height
    bool          fullScreen
  CODE:
    // no hash passed
    if (items == 5) {
        RETVAL = THIS->createRenderWindow(name, width, height, fullScreen);
    }
    else if (items == 6) {
        // wasn't a hash, skip it
        // xxx: I can't get the hashref test working....
        // if ((!SvROK(ST(5))) || (SvTYPE(SvRV(ST(5)) != SVt_PVHV))) {
        if (! SvROK(ST(5))) {
            RETVAL = THIS->createRenderWindow(name, width, height, fullScreen);
            warn("Ogre::Root::createRenderWindow() skipped non-hash 5th parameter\n");
        }
        // hash passed
        else {
            NameValuePairList params;
            HV *paramsHash = (HV *)SvRV(ST(5));
            STRLEN l;

            // wheeee....
            if (hv_exists(paramsHash, "title", 5))
              params["title"] = String((char *) SvPV(* hv_fetch(paramsHash, "title", 5, 0), l));
            if (hv_exists(paramsHash, "colourDepth", 11))
              params["colourDepth"] = String((char *) SvPV(* hv_fetch(paramsHash, "colourDepth", 11, 0), l));
            if (hv_exists(paramsHash, "left", 4))
              params["left"] = String((char *) SvPV(* hv_fetch(paramsHash, "left", 4, 0), l));
            if (hv_exists(paramsHash, "top", 3))
              params["top"] = String((char *) SvPV(* hv_fetch(paramsHash, "top", 3, 0), l));
            if (hv_exists(paramsHash, "depthBuffer", 11))
              params["depthBuffer"] = String((char *) SvPV(* hv_fetch(paramsHash, "depthBuffer", 11, 0), l));
            if (hv_exists(paramsHash, "externalWindowHandle", 20))
              params["externalWindowHandle"] = String((char *) SvPV(* hv_fetch(paramsHash, "externalWindowHandle", 20, 0), l));
            if (hv_exists(paramsHash, "externalGLControl", 17))
              params["externalGLControl"] = String((char *) SvPV(* hv_fetch(paramsHash, "externalGLControl", 17, 0), l));
            if (hv_exists(paramsHash, "externalGLContext", 17))
              params["externalGLContext"] = String((char *) SvPV(* hv_fetch(paramsHash, "externalGLContext", 17, 0), l));
            if (hv_exists(paramsHash, "parentWindowHandle", 18))
              params["parentWindowHandle"] = String((char *) SvPV(* hv_fetch(paramsHash, "parentWindowHandle", 18, 0), l));
            if (hv_exists(paramsHash, "FSAA", 4))
              params["FSAA"] = String((char *) SvPV(* hv_fetch(paramsHash, "FSAA", 4, 0), l));
            if (hv_exists(paramsHash, "displayFrequency", 16))
              params["displayFrequency"] = String((char *) SvPV(* hv_fetch(paramsHash, "displayFrequency", 16, 0), l));
            if (hv_exists(paramsHash, "vsync", 5))
              params["vsync"] = String((char *) SvPV(* hv_fetch(paramsHash, "vsync", 5, 0), l));
            if (hv_exists(paramsHash, "border", 6))
              params["border"] = String((char *) SvPV(* hv_fetch(paramsHash, "border", 6, 0), l));
            if (hv_exists(paramsHash, "outerDimensions", 15))
              params["outerDimensions"] = String((char *) SvPV(* hv_fetch(paramsHash, "outerDimensions", 15, 0), l));
            if (hv_exists(paramsHash, "useNVPerfHUD", 12))
              params["useNVPerfHUD"] = String((char *) SvPV(* hv_fetch(paramsHash, "useNVPerfHUD", 12, 0), l));

            RETVAL = THIS->createRenderWindow(name, width, height, fullScreen, &params);
        }
    }
  OUTPUT:
    RETVAL

# xxx: 2 versions
void
Root::detachRenderTarget(name)
    String  name

RenderTarget *
Root::getRenderTarget(name)
    String  name

void
Root::loadPlugin(pluginName)
    String  pluginName

void
Root::unloadPlugin(pluginName)
    String  pluginName

# installPlugin, uninstallPlugin, ..., getTimer

unsigned long
Root::getNextFrameNumber()


# ...


void
Root::clearEventTimes()

void
Root::setFrameSmoothingPeriod(period)
    Real  period

Real
Root::getFrameSmoothingPeriod()


# ...
