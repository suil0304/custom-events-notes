package interfaces;

import funkin.modding.module.Module;
import interfaces.IEventHandleable;

interface IEventHandlerOwner<T:(Module & IEventHandleable)> {
    public var handler:T;
}
