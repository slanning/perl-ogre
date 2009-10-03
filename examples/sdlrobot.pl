#!/usr/bin/perl

use strict;
use warnings;

use Ogre 0.38 qw(:SceneType);
use Ogre::ConfigFile;
use Ogre::ColourValue;
use Ogre::Light qw(:LightTypes);
use Ogre::Root;
use Ogre::ResourceGroupManager;
use Ogre::RenderWindow;
use Ogre::TextureManager;

use SDL;
use SDL::Constants qw/SDL_INIT_VIDEO SDL_OPENGL/;
use SDL::Event;

my ($W, $H, $D) = (1024, 768, 0);


main();
exit;


# http://www.ogre3d.org/wiki/index.php/Hello_World_with_minimal_Ogre_init
# http://www.ogre3d.org/wiki/index.php/Using_SDL_Input#New.2C_Experimental_Way_.28OGRE_v1.6_and_Later.29
sub main {
    SDL::Init(SDL_INIT_VIDEO);
    my $screen = SDL::SetVideoMode($W, $H, $D, SDL_OPENGL);
    SDL::WMSetCaption('SDL Window Title', 'SDL Icon Title');

    my $root = Ogre::Root->new('plugins.cfg', 'ogre.cfg', 'Ogre.log');
    defineResources();
    setupRenderSystem($root);

    $root->initialise(0);               # tell Ogre not to make an OpenGL window

    my $renderwindow = $root->createRenderWindow(
        'OgreRenderWindow', $W, $H, 0,
        {currentGLContext => 'True'},   # tell Ogre to use the SDL OpenGL context
    );

    Ogre::ResourceGroupManager->getSingletonPtr->initialiseAllResourceGroups();

    $renderwindow->setVisible(1);

    my $cam = setupScene($root, $renderwindow);

    #my $framelistener = createFrameListener($root, $renderwindow, $cam);

    mainLoop($root, $renderwindow, $cam);
}

sub mainLoop {
    my ($root, $renderwindow, $cam) = @_;

#     my $event = SDL::Event->new();
#     $event->poll();                         # Get the top one from the queue
#         while ($event->wait()) {
#                my $type = $event->type();      # get event type
#                # ... handle event
#                exit if $type == SDL_QUIT;
#         }


    moveCamPos($cam, 200);
    renderOne($root);

    # again, just to make sure it's rendering
    moveCamPos($cam, -200);
    sleep 1;
    renderOne($root);

    sleep 2;

}

sub createFrameListener {
    #
}

sub renderOne {
    my ($root) = @_;

    $root->renderOneFrame();            # Ogre renders to the SDL window
    SDL::GLSwapBuffers();
}

sub moveCamPos {
    my ($cam, $z) = @_;

    $cam->setPosition(0, 0, $z);
    $cam->lookAt(0, 50, 0);
}

sub setupScene {
    my ($root, $renderwindow) = @_;

    my $mgr = $root->createSceneManager(ST_GENERIC, 'Default SceneManager');

    my $cam = $mgr->createCamera('Camera');
    $cam->setNearClipDistance(5);

    my $vp = $renderwindow->addViewport($cam, 0, 0, 0, 1, 1);
    $vp->setBackgroundColour(Ogre::ColourValue->new(0.5, 0.5, 0.5, 1));

    $cam->setAspectRatio($vp->getActualWidth / $vp->getActualHeight);

    $mgr->setAmbientLight(Ogre::ColourValue->new(0.8, 0.7, 0.6, 1));
    my $ent1 = $mgr->createEntity('Robot', 'robot.mesh');
    my $node1 = $mgr->getRootSceneNode()->createChildSceneNode('RobotNode');
    $node1->attachObject($ent1);

    my $light = $mgr->createLight('Light1');
    $light->setType(LT_POINT);
    $light->setPosition(0, 0, 200);
    $light->setDiffuseColour(1.0, 0.0, 0.0);
    $light->setSpecularColour(1.0, 0.0, 0.0);

    return $cam;
}

sub setupRenderSystem {
    my $root = shift;
    if (! $root->restoreConfig() && ! $root->showConfigDialog()) {
        die "User cancelled the config dialog!\n";
    }
}

sub defineResources {
    my $cf = Ogre::ConfigFile->new();
    $cf->load('resources.cfg');

    my $secs = $cf->getSections();
    foreach my $sec (@$secs) {
        my $secname = $sec->{name};

        my $settings = $sec->{settings};
        foreach my $setting (@$settings) {
            my ($typename, $archname) = @$setting;
            # xxx: getSingletonPtr could move outside the foreach loops
            my $rgm = Ogre::ResourceGroupManager->getSingletonPtr();
            $rgm->addResourceLocation($archname, $typename, $secname);
        }
    }
}



__END__

use SDL::App;
use SDL::Color;
use SDL::Rect;

my $app = SDL::App->new(
    '-width'  => 640,
    '-height' => 480,
    '-depth'  => 16,
    '-title'  => 'My SDL Program',
);

my $color = SDL::Color->new(
    '-r' => 0x00,
    '-g' => 0x00,
    '-b' => 0xff,
);
my $rect = SDL::Rect->new(
    '-height' => 100,
    '-width'  => 100,
    '-x'      => 270,
    '-y'      => 390,
);

$app->fill($rect, $color);
$app->update($rect);

sleep 3;
