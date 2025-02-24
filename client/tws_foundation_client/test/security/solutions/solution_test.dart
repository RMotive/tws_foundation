import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/src/services/security/solutions/solution.dart';
import 'package:tws_foundation_client/src/sets/sets_module.dart';

void main() {
  test(
    'Encode',
    () {
      Solution obj = Solution(10, 'encode01', 'encd1', 'no-encode-desc');

      JObject encodeObj = obj.encode();
      assert(encodeObj[SetCommonKeys.kId] == obj.id);
      assert(encodeObj[SetCommonKeys.kName] == obj.name);
      assert(encodeObj[Solution.kSign] == obj.sign);
      assert(encodeObj[SetCommonKeys.kDescription] == obj.description);
    },
  );

  test(
    'Des',
    () {
      JObject encodedObj = <String, dynamic>{
        SetCommonKeys.kId: 10,
        SetCommonKeys.kName: 'encode01',
        Solution.kSign: 'encd1',
        SetCommonKeys.kDescription: 'no-encoded-desc',
      };

      Solution obj = Solution.des(encodedObj);
      assert(encodedObj[SetCommonKeys.kId] == obj.id);
      assert(encodedObj[SetCommonKeys.kName] == obj.name);
      assert(encodedObj[Solution.kSign] == obj.sign);
      assert(encodedObj[SetCommonKeys.kDescription] == obj.description);
    },
  );
}
