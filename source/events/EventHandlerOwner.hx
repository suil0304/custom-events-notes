package events;

// suil
import interfaces.IEventHandleable;

// funkin
import funkin.play.event.SongEvent;
import funkin.modding.module.Module;

abstract class EventHandlerOwner<D, H:(Module & IEventHandleable<D>)> extends SongEvent {
    var handler:H;
}
