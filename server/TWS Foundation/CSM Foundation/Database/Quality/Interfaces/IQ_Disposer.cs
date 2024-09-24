using CSM_Foundation.Database.Interfaces;

namespace CSM_Foundation.Database.Quality.Interfaces;
public interface IQ_Disposer {


    void Push(ISet Record);

    void Push(ISet[] Records);

    void Dispose();
}
