package interfaces;

interface IEventHandleable<T> {
    public function handleEvent(data:T):Void;
}
