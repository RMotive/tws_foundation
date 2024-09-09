using System.Net;
using System.Text.Json;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Enumerators;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Options.Filters;
using CSM_Foundation.Database.Models.Out;
using CSM_Foundation.Server.Records;

using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Foundation.Middlewares.Frames;
using TWS_Foundation.Quality.Bases;

using TWS_Security.Sets;

using View = CSM_Foundation.Database.Models.Out.SetViewOut<TWS_Security.Sets.Solution>;

namespace TWS_Foundation.Quality.Suit.Controllers.Security;


public class Q_SolutionsController
    : BQ_CustomServerController<Solution> {

    public Q_SolutionsController(WebApplicationFactory<Program> hostFactory)
        : base("Solutions", hostFactory) {
    }

    protected override Solution MockFactory(string RandomSeed) {
        return new Solution() {
            Name = RandomSeed,
            Description = RandomSeed,
            Sign = RandomSeed[..5],
        };
    }


    [Fact(DisplayName = "[View]: Simple page and size request")]
    public async Task ViewA() {
        (HttpStatusCode Status, ServerGenericFrame Response) = await Post("View", new SetViewOptions<Solution> {
            Page = 1,
            Range = 10,
            Retroactive = false,
        }, true);

        Assert.Equal(HttpStatusCode.OK, Status);

        View Estela = Framing<SuccessFrame<View>>(Response).Estela;
        Assert.True(Estela.Sets.Length > 0);
        Assert.Equal(1, Estela.Page);
        Assert.True(Estela.Pages > 0);
    }

    [Fact(DisplayName = "[View]: Specific date filter")]
    public async Task ViewC() {


    }

    [Fact(DisplayName = "[View]: Specific linear evaluation filter (OR)")]
    public async Task ViewB() {
        Solution[] mocks = MockFactory(10);

        (HttpStatusCode Status, ServerGenericFrame Response) creationOut = await Post("Create", mocks, true);
        Assert.Equal(HttpStatusCode.OK, creationOut.Status);

        SuccessFrame<SetComplexOut<Solution>> creationFrame = Framing<SuccessFrame<SetComplexOut<Solution>>>(creationOut.Response);
        Assert.Equal(creationFrame.Estela.QSuccesses, mocks.Length);


        (HttpStatusCode Status, ServerGenericFrame Response) = await Post("View", new SetViewOptions<Solution> {
            Retroactive = false,
            Range = 10,
            Page = 1,
            Filters = [
                new SetViewFilterLinearEvaluation<Solution> {
                    Operator = SetViewFilterEvaluationOperators.OR,
                    Filters = [
                        new SetViewPropertyFilter<Solution> {
                            Evaluation = SetViewFilterEvaluations.CONTAINS,
                            Property = nameof(Solution.Name),
                            Value = mocks[0].Name,
                        },
                        new SetViewPropertyFilter<Solution> {
                            Evaluation = SetViewFilterEvaluations.CONTAINS,
                            Property = nameof(Solution.Name),
                            Value = mocks[1].Name,
                        },
                    ]
                },
            ],
        }, true);

        Assert.Equal(HttpStatusCode.OK, Status);
        View Estela = Framing<SuccessFrame<View>>(Response).Estela;
        Assert.True(Estela.Sets.Length >= 2);
        Assert.Equal(1, Estela.Page);
        Assert.True(Estela.Pages > 0);

        foreach(Solution record in Estela.Sets) {

            Assert.True(record.Name == mocks[0].Name || record.Name == mocks[1].Name);
        }
    }

    [Fact]
    public async Task Create() {
        #region First (Correctly creates 3 Solutions)
        {
            Solution[] mocks = [];
            for (int i = 0; i < 3; i++) {
                string uniqueToken = Guid.NewGuid().ToString();

                mocks = [
                    ..mocks,
                    new Solution {
                        Name = $"{i}_{uniqueToken[..10]}",
                        Sign = $"{i}{uniqueToken[..4]}",
                    },
                ];
            }

            (HttpStatusCode Status, _) = await Post("Create", mocks, true);

            Assert.Equal(HttpStatusCode.OK, Status);
        }
        #endregion
    }

    [Fact]
    public async Task Update() {
        #region First (Correctly creates when doesn't exist)
        {
            (HttpStatusCode Status, ServerGenericFrame Respone) = await Post("Update", new Solution {
                Id = 0,
                Name = RandomUtils.String(10),
                Sign = RandomUtils.String(5),
                Description = RandomUtils.String(10),
            }, true);

            Assert.Equal(HttpStatusCode.OK, Status);
            RecordUpdateOut<Solution> creationResult = Framing<SuccessFrame<RecordUpdateOut<Solution>>>(Respone).Estela;

            Assert.Null(creationResult.Previous);

            Solution updated = creationResult.Updated;
            Assert.True(updated.Id > 0);
        }
        #endregion

        #region Second (Updates an exist record)
        {
            Solution mock = new() {
                Name = RandomUtils.String(10),
                Sign = RandomUtils.String(5),
                Description = RandomUtils.String(10),
            };
            (HttpStatusCode Status, ServerGenericFrame Response) = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, Status);

            RecordUpdateOut<Solution> creationResult = Framing<SuccessFrame<RecordUpdateOut<Solution>>>(Response).Estela;
            Assert.Null(creationResult.Previous);

            Solution creationRecord = creationResult.Updated;
            Assert.Multiple([
                () => Assert.True(creationRecord.Id > 0),
                () => Assert.Equal(mock.Name, creationRecord.Name),
                () => Assert.Equal(mock.Sign, creationRecord.Sign),
                () => Assert.Equal(mock.Description, creationRecord.Description),
            ]);

            mock.Id = creationRecord.Id;
            mock.Name = RandomUtils.String(10);
            (HttpStatusCode Status, ServerGenericFrame Response) updateResponse = await Post("Update", mock, true);

            Assert.Equal(HttpStatusCode.OK, updateResponse.Status);
            RecordUpdateOut<Solution> updateResult = Framing<SuccessFrame<RecordUpdateOut<Solution>>>(updateResponse.Response).Estela;

            Assert.NotNull(updateResult.Previous);

            Solution updateRecord = updateResult.Updated;
            Assert.Multiple([
                () => Assert.Equal(creationRecord.Id, updateRecord.Id),
                () => Assert.Equal(creationRecord.Sign, updateRecord.Sign),
                () => Assert.Equal(creationRecord.Description, updateRecord.Description),
                () => Assert.NotEqual(creationRecord.Name, updateRecord.Name),
            ]);
        }
        #endregion
    }
}