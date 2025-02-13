using CSM_Foundation.Database.Entity;

namespace CSM_Foundation.Database.Quality.Interfaces;
public interface IQ_Disposer {


    void Push(IEntity Record);

    void Push(IEntity[] Records);

    void Dispose();
}
