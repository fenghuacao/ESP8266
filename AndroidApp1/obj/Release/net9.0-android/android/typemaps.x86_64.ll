; ModuleID = 'typemaps.x86_64.ll'
source_filename = "typemaps.x86_64.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-android21"

%struct.TypeMapJava = type {
	i32, ; uint32_t module_index
	i32, ; uint32_t type_token_id
	i32 ; uint32_t java_name_index
}

%struct.TypeMapModule = type {
	[16 x i8], ; uint8_t module_uuid[16]
	i32, ; uint32_t entry_count
	i32, ; uint32_t duplicate_count
	ptr, ; TypeMapModuleEntry map
	ptr, ; TypeMapModuleEntry duplicate_map
	ptr, ; char* assembly_name
	ptr, ; MonoImage image
	i32, ; uint32_t java_name_width
	ptr ; uint8_t java_map
}

%struct.TypeMapModuleEntry = type {
	i32, ; uint32_t type_token_id
	i32 ; uint32_t java_map_index
}

@map_module_count = dso_local local_unnamed_addr constant i32 2, align 4

@java_type_count = dso_local local_unnamed_addr constant i32 121, align 4

; Managed modules map
@map_modules = dso_local local_unnamed_addr global [2 x %struct.TypeMapModule] [
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xb4, i8 u0xb6, i8 u0xb3, i8 u0x11, i8 u0x19, i8 u0x7f, i8 u0xce, i8 u0x4f, i8 u0x83, i8 u0xd5, i8 u0x4e, i8 u0xd7, i8 u0xf2, i8 u0x45, i8 u0xa8, i8 u0xe3 ], ; module_uuid: 11b3b6b4-7f19-4fce-83d5-4ed7f245a8e3
		i32 120, ; uint32_t entry_count
		i32 42, ; uint32_t duplicate_count
		ptr @module0_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module0_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.0_assembly_name, ; assembly_name: Mono.Android
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 0
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xc8, i8 u0xb8, i8 u0xc2, i8 u0x56, i8 u0xf3, i8 u0x4e, i8 u0x29, i8 u0x44, i8 u0x98, i8 u0x4b, i8 u0x44, i8 u0x37, i8 u0xc7, i8 u0xc3, i8 u0x42, i8 u0xb8 ], ; module_uuid: 56c2b8c8-4ef3-4429-984b-4437c7c342b8
		i32 1, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module1_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.1_assembly_name, ; assembly_name: AndroidApp1
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	} ; 1
], align 16

; Java types name hashes
@map_java_hashes = dso_local local_unnamed_addr constant [121 x i64] [
	i64 u0x013d70f30586d278, ; 0 => javax/net/ssl/KeyManagerFactory
	i64 u0x01cd624f1e38cc9f, ; 1 => java/lang/Byte
	i64 u0x03cc98b851d4262c, ; 2 => javax/net/ssl/SSLContext
	i64 u0x06f84afe4273c430, ; 3 => java/net/InetSocketAddress
	i64 u0x083e83bb2321dd50, ; 4 => java/util/Random
	i64 u0x0b1da699fb29019a, ; 5 => android/os/BaseBundle
	i64 u0x0c44130caa233945, ; 6 => mono/android/runtime/JavaObject
	i64 u0x0d9335f0988cd796, ; 7 => java/util/HashMap
	i64 u0x106be7c89662702e, ; 8 => java/net/Proxy$Type
	i64 u0x10e015905ca8bd0f, ; 9 => java/security/cert/Certificate
	i64 u0x116532ec07ee0771, ; 10 => java/security/spec/KeySpec
	i64 u0x13e5902d3b855db6, ; 11 => javax/net/ssl/TrustManagerFactory
	i64 u0x1e04bf19f9c14045, ; 12 => android/util/AttributeSet
	i64 u0x1e549855226528a2, ; 13 => java/io/InterruptedIOException
	i64 u0x1e69018626ef9ffb, ; 14 => android/os/Handler
	i64 u0x21b381333982058e, ; 15 => javax/net/SocketFactory
	i64 u0x225c20a45cb91cd7, ; 16 => java/lang/Error
	i64 u0x2a15272bf231e341, ; 17 => android/widget/EditText
	i64 u0x2bcca4a8219ac237, ; 18 => javax/security/cert/X509Certificate
	i64 u0x2d394d9ef707bb4c, ; 19 => android/widget/AbsSeekBar
	i64 u0x2ff9fb2c70f4f954, ; 20 => java/lang/SecurityException
	i64 u0x332031975eda7654, ; 21 => java/lang/Boolean
	i64 u0x3436cf09b45d055e, ; 22 => java/security/Principal
	i64 u0x35e989807a64bcd9, ; 23 => java/lang/IllegalStateException
	i64 u0x406e54c64b3bee74, ; 24 => android/runtime/JavaProxyThrowable
	i64 u0x40c05cff47992547, ; 25 => android/view/ViewGroup
	i64 u0x41d091ef7039ab94, ; 26 => java/net/URLConnection
	i64 u0x4209344bc1b095c1, ; 27 => java/net/ProtocolException
	i64 u0x48e1abb584b78c94, ; 28 => java/io/Writer
	i64 u0x4a39213a97fe1b2f, ; 29 => java/net/ConnectException
	i64 u0x4fd00d1ec1741ca6, ; 30 => crc64a6e0c00971f6cd91/MainActivity
	i64 u0x5181b129b1a25949, ; 31 => java/lang/Class
	i64 u0x5238ad63b58da994, ; 32 => java/lang/ClassCastException
	i64 u0x529e559bd64e4c22, ; 33 => javax/net/ssl/HttpsURLConnection
	i64 u0x54c5d3387059fe2c, ; 34 => mono/android/view/View_OnClickListenerImplementor
	i64 u0x551ac881eb4466c0, ; 35 => java/lang/Number
	i64 u0x56365290d5a06704, ; 36 => java/lang/LinkageError
	i64 u0x57fe4a40460344db, ; 37 => android/os/Build$VERSION
	i64 u0x5a6af884fe3c181e, ; 38 => android/os/Bundle
	i64 u0x5b905726d9bc975f, ; 39 => android/widget/TextView
	i64 u0x5bb3e0a8d6cb4895, ; 40 => mono/android/widget/SeekBar_OnSeekBarChangeListenerImplementor
	i64 u0x5bfd65ae1a6e6ffc, ; 41 => android/app/Activity
	i64 u0x5f5a9fc3430795a4, ; 42 => android/content/ContextWrapper
	i64 u0x5f7e709faf8646e0, ; 43 => java/lang/Short
	i64 u0x6219335ac57fb821, ; 44 => java/io/Serializable
	i64 u0x65f6b14b7e978927, ; 45 => java/io/IOException
	i64 u0x6aa7d9af28b4551f, ; 46 => java/net/SocketTimeoutException
	i64 u0x6e0fb15bd0f04d15, ; 47 => java/lang/StackTraceElement
	i64 u0x714152b8b4c7f7d6, ; 48 => java/security/KeyFactory
	i64 u0x720cd712e1248c34, ; 49 => java/util/Iterator
	i64 u0x75591c18ddf5e52d, ; 50 => mono/android/TypeManager
	i64 u0x76cbd2104dd555ed, ; 51 => android/content/Context
	i64 u0x77f013f4840c6e9d, ; 52 => android/widget/SeekBar$OnSeekBarChangeListener
	i64 u0x7b3aeb75b65cbd49, ; 53 => java/security/spec/PKCS8EncodedKeySpec
	i64 u0x7b925bdca68a0101, ; 54 => java/util/ArrayList
	i64 u0x7c93df30f68cf9a7, ; 55 => javax/security/auth/Subject
	i64 u0x7fc6286783d5249d, ; 56 => java/security/Key
	i64 u0x7fd6b531797aa365, ; 57 => java/net/URL
	i64 u0x83314b5931a387fb, ; 58 => android/widget/Toast
	i64 u0x84f94178aab6cc34, ; 59 => java/lang/CharSequence
	i64 u0x888700b03d541d93, ; 60 => java/lang/RuntimeException
	i64 u0x88f7510c649f4a97, ; 61 => java/io/InputStream
	i64 u0x8a1927818aa18084, ; 62 => javax/net/ssl/KeyManager
	i64 u0x8a3ea3c274e8ce68, ; 63 => java/lang/Character
	i64 u0x90b4aeb45636cd6a, ; 64 => mono/android/runtime/OutputStreamAdapter
	i64 u0x92188d393e2af2d2, ; 65 => java/lang/Throwable
	i64 u0x92b59c839bc46278, ; 66 => java/lang/Thread
	i64 u0x965bfaf1ff1da014, ; 67 => java/lang/ReflectiveOperationException
	i64 u0x98ba110c6c57da31, ; 68 => java/lang/Float
	i64 u0x99df91bab800c287, ; 69 => mono/android/runtime/InputStreamAdapter
	i64 u0x9e10a0b3efa170dc, ; 70 => android/view/ContextThemeWrapper
	i64 u0x9e6dc3e8eedaf8a8, ; 71 => java/net/SocketException
	i64 u0x9fa1370a1b1093fa, ; 72 => java/lang/NullPointerException
	i64 u0xa07cbd8408019386, ; 73 => java/net/Proxy
	i64 u0xa1f69eeebebd7ca5, ; 74 => android/widget/ProgressBar
	i64 u0xa59db4b8b7dbe046, ; 75 => javax/net/ssl/SSLSession
	i64 u0xa865adbdd81d9951, ; 76 => java/io/OutputStream
	i64 u0xa95eae500754348a, ; 77 => java/net/SocketAddress
	i64 u0xaa75ead031784774, ; 78 => javax/net/ssl/SSLSocketFactory
	i64 u0xabc3cd0f40f748aa, ; 79 => java/lang/String
	i64 u0xac9902bb0e4c5217, ; 80 => java/lang/IllegalArgumentException
	i64 u0xacbf549cdef93bef, ; 81 => java/net/HttpURLConnection
	i64 u0xb02badeb1c97535c, ; 82 => java/lang/Integer
	i64 u0xb18d71343ca8e96f, ; 83 => java/lang/Exception
	i64 u0xb8df224d6b778ca3, ; 84 => android/view/View
	i64 u0xb9e48b25660487c5, ; 85 => javax/net/ssl/TrustManager
	i64 u0xbb41c32523812652, ; 86 => android/widget/Button
	i64 u0xbb84ccbe48f6c18b, ; 87 => android/os/Looper
	i64 u0xbf6d427143271cb3, ; 88 => java/lang/Object
	i64 u0xc00f4c2f11efdcff, ; 89 => java/lang/ClassNotFoundException
	i64 u0xc2512364d51a7359, ; 90 => android/widget/SeekBar
	i64 u0xc2a8e50a5f08afc6, ; 91 => mono/java/lang/RunnableImplementor
	i64 u0xc3eb0cbb47f178b9, ; 92 => java/lang/Enum
	i64 u0xc99e090e60d66f58, ; 93 => java/io/StringWriter
	i64 u0xca35caf567cfa745, ; 94 => java/util/Collection
	i64 u0xcabf871ef950ad91, ; 95 => android/view/View$OnClickListener
	i64 u0xcc306823503920e9, ; 96 => android/app/Application
	i64 u0xd1b288a9c7bb8f53, ; 97 => java/lang/Double
	i64 u0xd5a28b8fa6d48e71, ; 98 => android/os/Build
	i64 u0xdd812f1d4afa427b, ; 99 => java/lang/UnsupportedOperationException
	i64 u0xde36efb42da7cc2d, ; 100 => javax/net/ssl/SSLSessionContext
	i64 u0xe024b538ad65ea66, ; 101 => java/util/function/Consumer
	i64 u0xe0446bf91fb0c2dd, ; 102 => java/lang/NoClassDefFoundError
	i64 u0xe1b3c5871398eb28, ; 103 => java/nio/channels/FileChannel
	i64 u0xe28cd0a2e6de00c1, ; 104 => java/security/KeyStore
	i64 u0xe59c130e7d1e4ac3, ; 105 => java/security/SecureRandom
	i64 u0xeb82145dcac4c559, ; 106 => java/lang/Long
	i64 u0xed49ed70aa9be1b3, ; 107 => java/nio/channels/spi/AbstractInterruptibleChannel
	i64 u0xee58348f4c4ad939, ; 108 => javax/net/ssl/HostnameVerifier
	i64 u0xee6f3d1e7507d907, ; 109 => java/util/Enumeration
	i64 u0xef2f2996a1d369cc, ; 110 => java/io/FileInputStream
	i64 u0xef953c41325a3428, ; 111 => java/io/PrintWriter
	i64 u0xefd8c7aa4b48418e, ; 112 => android/widget/LinearLayout
	i64 u0xf11f22a6441fcfbc, ; 113 => java/lang/IndexOutOfBoundsException
	i64 u0xf3d4ab08aaf25ccb, ; 114 => java/net/UnknownServiceException
	i64 u0xf85cbededb432844, ; 115 => java/security/spec/EncodedKeySpec
	i64 u0xfb0541dba11b69d9, ; 116 => android/graphics/Color
	i64 u0xfb9a51a22eb2843f, ; 117 => javax/security/cert/Certificate
	i64 u0xfbe9bfa5cc50fed6, ; 118 => java/util/HashSet
	i64 u0xfd2b1a3de667eb51, ; 119 => java/lang/Runnable
	i64 u0xfebf2b77f1940e7e ; 120 => java/security/PrivateKey
], align 16

@module0_managed_to_java = internal dso_local constant [120 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000057, ; uint32_t type_token_id
		i32 117; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000059, ; uint32_t type_token_id
		i32 18; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200005b, ; uint32_t type_token_id
		i32 55; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200005c, ; uint32_t type_token_id
		i32 15; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x0200005e, ; uint32_t type_token_id
		i32 33; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000060, ; uint32_t type_token_id
		i32 108; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000062, ; uint32_t type_token_id
		i32 62; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000064, ; uint32_t type_token_id
		i32 75; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000066, ; uint32_t type_token_id
		i32 100; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x02000068, ; uint32_t type_token_id
		i32 85; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x0200006a, ; uint32_t type_token_id
		i32 0; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x0200006b, ; uint32_t type_token_id
		i32 2; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x0200006c, ; uint32_t type_token_id
		i32 78; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x0200006e, ; uint32_t type_token_id
		i32 11; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x0200006f, ; uint32_t type_token_id
		i32 39; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x02000070, ; uint32_t type_token_id
		i32 19; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x02000072, ; uint32_t type_token_id
		i32 86; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x02000073, ; uint32_t type_token_id
		i32 17; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x02000074, ; uint32_t type_token_id
		i32 112; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x02000075, ; uint32_t type_token_id
		i32 74; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x02000076, ; uint32_t type_token_id
		i32 90; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x02000077, ; uint32_t type_token_id
		i32 52; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x0200007c, ; uint32_t type_token_id
		i32 40; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x02000080, ; uint32_t type_token_id
		i32 58; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x02000082, ; uint32_t type_token_id
		i32 12; uint32_t java_map_index
	}, ; 24
	%struct.TypeMapModuleEntry {
		i32 u0x02000084, ; uint32_t type_token_id
		i32 14; uint32_t java_map_index
	}, ; 25
	%struct.TypeMapModuleEntry {
		i32 u0x02000085, ; uint32_t type_token_id
		i32 5; uint32_t java_map_index
	}, ; 26
	%struct.TypeMapModuleEntry {
		i32 u0x02000086, ; uint32_t type_token_id
		i32 98; uint32_t java_map_index
	}, ; 27
	%struct.TypeMapModuleEntry {
		i32 u0x02000087, ; uint32_t type_token_id
		i32 37; uint32_t java_map_index
	}, ; 28
	%struct.TypeMapModuleEntry {
		i32 u0x02000089, ; uint32_t type_token_id
		i32 38; uint32_t java_map_index
	}, ; 29
	%struct.TypeMapModuleEntry {
		i32 u0x0200008a, ; uint32_t type_token_id
		i32 87; uint32_t java_map_index
	}, ; 30
	%struct.TypeMapModuleEntry {
		i32 u0x0200008b, ; uint32_t type_token_id
		i32 84; uint32_t java_map_index
	}, ; 31
	%struct.TypeMapModuleEntry {
		i32 u0x0200008c, ; uint32_t type_token_id
		i32 95; uint32_t java_map_index
	}, ; 32
	%struct.TypeMapModuleEntry {
		i32 u0x0200008e, ; uint32_t type_token_id
		i32 34; uint32_t java_map_index
	}, ; 33
	%struct.TypeMapModuleEntry {
		i32 u0x02000092, ; uint32_t type_token_id
		i32 70; uint32_t java_map_index
	}, ; 34
	%struct.TypeMapModuleEntry {
		i32 u0x02000093, ; uint32_t type_token_id
		i32 25; uint32_t java_map_index
	}, ; 35
	%struct.TypeMapModuleEntry {
		i32 u0x020000aa, ; uint32_t type_token_id
		i32 69; uint32_t java_map_index
	}, ; 36
	%struct.TypeMapModuleEntry {
		i32 u0x020000ac, ; uint32_t type_token_id
		i32 94; uint32_t java_map_index
	}, ; 37
	%struct.TypeMapModuleEntry {
		i32 u0x020000ae, ; uint32_t type_token_id
		i32 7; uint32_t java_map_index
	}, ; 38
	%struct.TypeMapModuleEntry {
		i32 u0x020000b7, ; uint32_t type_token_id
		i32 54; uint32_t java_map_index
	}, ; 39
	%struct.TypeMapModuleEntry {
		i32 u0x020000b9, ; uint32_t type_token_id
		i32 6; uint32_t java_map_index
	}, ; 40
	%struct.TypeMapModuleEntry {
		i32 u0x020000ba, ; uint32_t type_token_id
		i32 24; uint32_t java_map_index
	}, ; 41
	%struct.TypeMapModuleEntry {
		i32 u0x020000bb, ; uint32_t type_token_id
		i32 118; uint32_t java_map_index
	}, ; 42
	%struct.TypeMapModuleEntry {
		i32 u0x020000c7, ; uint32_t type_token_id
		i32 64; uint32_t java_map_index
	}, ; 43
	%struct.TypeMapModuleEntry {
		i32 u0x020000cf, ; uint32_t type_token_id
		i32 116; uint32_t java_map_index
	}, ; 44
	%struct.TypeMapModuleEntry {
		i32 u0x020000d0, ; uint32_t type_token_id
		i32 51; uint32_t java_map_index
	}, ; 45
	%struct.TypeMapModuleEntry {
		i32 u0x020000d2, ; uint32_t type_token_id
		i32 42; uint32_t java_map_index
	}, ; 46
	%struct.TypeMapModuleEntry {
		i32 u0x020000d4, ; uint32_t type_token_id
		i32 41; uint32_t java_map_index
	}, ; 47
	%struct.TypeMapModuleEntry {
		i32 u0x020000d5, ; uint32_t type_token_id
		i32 96; uint32_t java_map_index
	}, ; 48
	%struct.TypeMapModuleEntry {
		i32 u0x020000d9, ; uint32_t type_token_id
		i32 29; uint32_t java_map_index
	}, ; 49
	%struct.TypeMapModuleEntry {
		i32 u0x020000db, ; uint32_t type_token_id
		i32 81; uint32_t java_map_index
	}, ; 50
	%struct.TypeMapModuleEntry {
		i32 u0x020000dd, ; uint32_t type_token_id
		i32 3; uint32_t java_map_index
	}, ; 51
	%struct.TypeMapModuleEntry {
		i32 u0x020000de, ; uint32_t type_token_id
		i32 27; uint32_t java_map_index
	}, ; 52
	%struct.TypeMapModuleEntry {
		i32 u0x020000df, ; uint32_t type_token_id
		i32 73; uint32_t java_map_index
	}, ; 53
	%struct.TypeMapModuleEntry {
		i32 u0x020000e0, ; uint32_t type_token_id
		i32 8; uint32_t java_map_index
	}, ; 54
	%struct.TypeMapModuleEntry {
		i32 u0x020000e1, ; uint32_t type_token_id
		i32 77; uint32_t java_map_index
	}, ; 55
	%struct.TypeMapModuleEntry {
		i32 u0x020000e3, ; uint32_t type_token_id
		i32 71; uint32_t java_map_index
	}, ; 56
	%struct.TypeMapModuleEntry {
		i32 u0x020000e4, ; uint32_t type_token_id
		i32 46; uint32_t java_map_index
	}, ; 57
	%struct.TypeMapModuleEntry {
		i32 u0x020000e5, ; uint32_t type_token_id
		i32 114; uint32_t java_map_index
	}, ; 58
	%struct.TypeMapModuleEntry {
		i32 u0x020000e6, ; uint32_t type_token_id
		i32 57; uint32_t java_map_index
	}, ; 59
	%struct.TypeMapModuleEntry {
		i32 u0x020000e7, ; uint32_t type_token_id
		i32 26; uint32_t java_map_index
	}, ; 60
	%struct.TypeMapModuleEntry {
		i32 u0x020000e9, ; uint32_t type_token_id
		i32 56; uint32_t java_map_index
	}, ; 61
	%struct.TypeMapModuleEntry {
		i32 u0x020000eb, ; uint32_t type_token_id
		i32 22; uint32_t java_map_index
	}, ; 62
	%struct.TypeMapModuleEntry {
		i32 u0x020000ed, ; uint32_t type_token_id
		i32 120; uint32_t java_map_index
	}, ; 63
	%struct.TypeMapModuleEntry {
		i32 u0x020000ef, ; uint32_t type_token_id
		i32 48; uint32_t java_map_index
	}, ; 64
	%struct.TypeMapModuleEntry {
		i32 u0x020000f0, ; uint32_t type_token_id
		i32 104; uint32_t java_map_index
	}, ; 65
	%struct.TypeMapModuleEntry {
		i32 u0x020000f1, ; uint32_t type_token_id
		i32 105; uint32_t java_map_index
	}, ; 66
	%struct.TypeMapModuleEntry {
		i32 u0x020000f2, ; uint32_t type_token_id
		i32 115; uint32_t java_map_index
	}, ; 67
	%struct.TypeMapModuleEntry {
		i32 u0x020000f4, ; uint32_t type_token_id
		i32 10; uint32_t java_map_index
	}, ; 68
	%struct.TypeMapModuleEntry {
		i32 u0x020000f6, ; uint32_t type_token_id
		i32 53; uint32_t java_map_index
	}, ; 69
	%struct.TypeMapModuleEntry {
		i32 u0x020000f7, ; uint32_t type_token_id
		i32 9; uint32_t java_map_index
	}, ; 70
	%struct.TypeMapModuleEntry {
		i32 u0x020000f9, ; uint32_t type_token_id
		i32 103; uint32_t java_map_index
	}, ; 71
	%struct.TypeMapModuleEntry {
		i32 u0x020000fb, ; uint32_t type_token_id
		i32 107; uint32_t java_map_index
	}, ; 72
	%struct.TypeMapModuleEntry {
		i32 u0x020000fd, ; uint32_t type_token_id
		i32 110; uint32_t java_map_index
	}, ; 73
	%struct.TypeMapModuleEntry {
		i32 u0x020000fe, ; uint32_t type_token_id
		i32 61; uint32_t java_map_index
	}, ; 74
	%struct.TypeMapModuleEntry {
		i32 u0x02000100, ; uint32_t type_token_id
		i32 13; uint32_t java_map_index
	}, ; 75
	%struct.TypeMapModuleEntry {
		i32 u0x02000101, ; uint32_t type_token_id
		i32 45; uint32_t java_map_index
	}, ; 76
	%struct.TypeMapModuleEntry {
		i32 u0x02000102, ; uint32_t type_token_id
		i32 44; uint32_t java_map_index
	}, ; 77
	%struct.TypeMapModuleEntry {
		i32 u0x02000104, ; uint32_t type_token_id
		i32 76; uint32_t java_map_index
	}, ; 78
	%struct.TypeMapModuleEntry {
		i32 u0x02000106, ; uint32_t type_token_id
		i32 111; uint32_t java_map_index
	}, ; 79
	%struct.TypeMapModuleEntry {
		i32 u0x02000107, ; uint32_t type_token_id
		i32 93; uint32_t java_map_index
	}, ; 80
	%struct.TypeMapModuleEntry {
		i32 u0x02000108, ; uint32_t type_token_id
		i32 28; uint32_t java_map_index
	}, ; 81
	%struct.TypeMapModuleEntry {
		i32 u0x0200010a, ; uint32_t type_token_id
		i32 109; uint32_t java_map_index
	}, ; 82
	%struct.TypeMapModuleEntry {
		i32 u0x0200010c, ; uint32_t type_token_id
		i32 49; uint32_t java_map_index
	}, ; 83
	%struct.TypeMapModuleEntry {
		i32 u0x0200010e, ; uint32_t type_token_id
		i32 4; uint32_t java_map_index
	}, ; 84
	%struct.TypeMapModuleEntry {
		i32 u0x0200010f, ; uint32_t type_token_id
		i32 101; uint32_t java_map_index
	}, ; 85
	%struct.TypeMapModuleEntry {
		i32 u0x02000111, ; uint32_t type_token_id
		i32 21; uint32_t java_map_index
	}, ; 86
	%struct.TypeMapModuleEntry {
		i32 u0x02000112, ; uint32_t type_token_id
		i32 1; uint32_t java_map_index
	}, ; 87
	%struct.TypeMapModuleEntry {
		i32 u0x02000113, ; uint32_t type_token_id
		i32 63; uint32_t java_map_index
	}, ; 88
	%struct.TypeMapModuleEntry {
		i32 u0x02000114, ; uint32_t type_token_id
		i32 31; uint32_t java_map_index
	}, ; 89
	%struct.TypeMapModuleEntry {
		i32 u0x02000115, ; uint32_t type_token_id
		i32 89; uint32_t java_map_index
	}, ; 90
	%struct.TypeMapModuleEntry {
		i32 u0x02000116, ; uint32_t type_token_id
		i32 97; uint32_t java_map_index
	}, ; 91
	%struct.TypeMapModuleEntry {
		i32 u0x02000117, ; uint32_t type_token_id
		i32 83; uint32_t java_map_index
	}, ; 92
	%struct.TypeMapModuleEntry {
		i32 u0x02000118, ; uint32_t type_token_id
		i32 68; uint32_t java_map_index
	}, ; 93
	%struct.TypeMapModuleEntry {
		i32 u0x02000119, ; uint32_t type_token_id
		i32 59; uint32_t java_map_index
	}, ; 94
	%struct.TypeMapModuleEntry {
		i32 u0x0200011a, ; uint32_t type_token_id
		i32 82; uint32_t java_map_index
	}, ; 95
	%struct.TypeMapModuleEntry {
		i32 u0x0200011b, ; uint32_t type_token_id
		i32 106; uint32_t java_map_index
	}, ; 96
	%struct.TypeMapModuleEntry {
		i32 u0x0200011c, ; uint32_t type_token_id
		i32 88; uint32_t java_map_index
	}, ; 97
	%struct.TypeMapModuleEntry {
		i32 u0x0200011d, ; uint32_t type_token_id
		i32 60; uint32_t java_map_index
	}, ; 98
	%struct.TypeMapModuleEntry {
		i32 u0x0200011e, ; uint32_t type_token_id
		i32 43; uint32_t java_map_index
	}, ; 99
	%struct.TypeMapModuleEntry {
		i32 u0x0200011f, ; uint32_t type_token_id
		i32 79; uint32_t java_map_index
	}, ; 100
	%struct.TypeMapModuleEntry {
		i32 u0x02000121, ; uint32_t type_token_id
		i32 66; uint32_t java_map_index
	}, ; 101
	%struct.TypeMapModuleEntry {
		i32 u0x02000122, ; uint32_t type_token_id
		i32 91; uint32_t java_map_index
	}, ; 102
	%struct.TypeMapModuleEntry {
		i32 u0x02000123, ; uint32_t type_token_id
		i32 65; uint32_t java_map_index
	}, ; 103
	%struct.TypeMapModuleEntry {
		i32 u0x02000124, ; uint32_t type_token_id
		i32 32; uint32_t java_map_index
	}, ; 104
	%struct.TypeMapModuleEntry {
		i32 u0x02000125, ; uint32_t type_token_id
		i32 92; uint32_t java_map_index
	}, ; 105
	%struct.TypeMapModuleEntry {
		i32 u0x02000127, ; uint32_t type_token_id
		i32 16; uint32_t java_map_index
	}, ; 106
	%struct.TypeMapModuleEntry {
		i32 u0x0200012a, ; uint32_t type_token_id
		i32 80; uint32_t java_map_index
	}, ; 107
	%struct.TypeMapModuleEntry {
		i32 u0x0200012b, ; uint32_t type_token_id
		i32 23; uint32_t java_map_index
	}, ; 108
	%struct.TypeMapModuleEntry {
		i32 u0x0200012c, ; uint32_t type_token_id
		i32 113; uint32_t java_map_index
	}, ; 109
	%struct.TypeMapModuleEntry {
		i32 u0x0200012d, ; uint32_t type_token_id
		i32 119; uint32_t java_map_index
	}, ; 110
	%struct.TypeMapModuleEntry {
		i32 u0x0200012f, ; uint32_t type_token_id
		i32 36; uint32_t java_map_index
	}, ; 111
	%struct.TypeMapModuleEntry {
		i32 u0x02000130, ; uint32_t type_token_id
		i32 102; uint32_t java_map_index
	}, ; 112
	%struct.TypeMapModuleEntry {
		i32 u0x02000131, ; uint32_t type_token_id
		i32 72; uint32_t java_map_index
	}, ; 113
	%struct.TypeMapModuleEntry {
		i32 u0x02000132, ; uint32_t type_token_id
		i32 35; uint32_t java_map_index
	}, ; 114
	%struct.TypeMapModuleEntry {
		i32 u0x02000134, ; uint32_t type_token_id
		i32 67; uint32_t java_map_index
	}, ; 115
	%struct.TypeMapModuleEntry {
		i32 u0x02000135, ; uint32_t type_token_id
		i32 20; uint32_t java_map_index
	}, ; 116
	%struct.TypeMapModuleEntry {
		i32 u0x02000136, ; uint32_t type_token_id
		i32 47; uint32_t java_map_index
	}, ; 117
	%struct.TypeMapModuleEntry {
		i32 u0x02000137, ; uint32_t type_token_id
		i32 99; uint32_t java_map_index
	}, ; 118
	%struct.TypeMapModuleEntry {
		i32 u0x02000146, ; uint32_t type_token_id
		i32 50; uint32_t java_map_index
	} ; 119
], align 16

@module0_managed_to_java_duplicates = internal dso_local constant [42 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000058, ; uint32_t type_token_id
		i32 117; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200005a, ; uint32_t type_token_id
		i32 18; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200005d, ; uint32_t type_token_id
		i32 15; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200005f, ; uint32_t type_token_id
		i32 33; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000061, ; uint32_t type_token_id
		i32 108; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000063, ; uint32_t type_token_id
		i32 62; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000065, ; uint32_t type_token_id
		i32 75; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000067, ; uint32_t type_token_id
		i32 100; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000069, ; uint32_t type_token_id
		i32 85; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x0200006d, ; uint32_t type_token_id
		i32 78; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x02000071, ; uint32_t type_token_id
		i32 19; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x02000078, ; uint32_t type_token_id
		i32 52; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x02000083, ; uint32_t type_token_id
		i32 12; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x0200008d, ; uint32_t type_token_id
		i32 95; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x02000094, ; uint32_t type_token_id
		i32 25; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x020000ad, ; uint32_t type_token_id
		i32 94; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x020000b3, ; uint32_t type_token_id
		i32 7; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x020000b8, ; uint32_t type_token_id
		i32 54; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x020000bc, ; uint32_t type_token_id
		i32 118; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x020000d1, ; uint32_t type_token_id
		i32 51; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x020000dc, ; uint32_t type_token_id
		i32 81; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x020000e2, ; uint32_t type_token_id
		i32 77; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x020000e8, ; uint32_t type_token_id
		i32 26; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x020000ea, ; uint32_t type_token_id
		i32 56; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x020000ec, ; uint32_t type_token_id
		i32 22; uint32_t java_map_index
	}, ; 24
	%struct.TypeMapModuleEntry {
		i32 u0x020000ee, ; uint32_t type_token_id
		i32 120; uint32_t java_map_index
	}, ; 25
	%struct.TypeMapModuleEntry {
		i32 u0x020000f3, ; uint32_t type_token_id
		i32 115; uint32_t java_map_index
	}, ; 26
	%struct.TypeMapModuleEntry {
		i32 u0x020000f5, ; uint32_t type_token_id
		i32 10; uint32_t java_map_index
	}, ; 27
	%struct.TypeMapModuleEntry {
		i32 u0x020000f8, ; uint32_t type_token_id
		i32 9; uint32_t java_map_index
	}, ; 28
	%struct.TypeMapModuleEntry {
		i32 u0x020000fa, ; uint32_t type_token_id
		i32 103; uint32_t java_map_index
	}, ; 29
	%struct.TypeMapModuleEntry {
		i32 u0x020000fc, ; uint32_t type_token_id
		i32 107; uint32_t java_map_index
	}, ; 30
	%struct.TypeMapModuleEntry {
		i32 u0x020000ff, ; uint32_t type_token_id
		i32 61; uint32_t java_map_index
	}, ; 31
	%struct.TypeMapModuleEntry {
		i32 u0x02000103, ; uint32_t type_token_id
		i32 44; uint32_t java_map_index
	}, ; 32
	%struct.TypeMapModuleEntry {
		i32 u0x02000105, ; uint32_t type_token_id
		i32 76; uint32_t java_map_index
	}, ; 33
	%struct.TypeMapModuleEntry {
		i32 u0x02000109, ; uint32_t type_token_id
		i32 28; uint32_t java_map_index
	}, ; 34
	%struct.TypeMapModuleEntry {
		i32 u0x0200010b, ; uint32_t type_token_id
		i32 109; uint32_t java_map_index
	}, ; 35
	%struct.TypeMapModuleEntry {
		i32 u0x0200010d, ; uint32_t type_token_id
		i32 49; uint32_t java_map_index
	}, ; 36
	%struct.TypeMapModuleEntry {
		i32 u0x02000110, ; uint32_t type_token_id
		i32 101; uint32_t java_map_index
	}, ; 37
	%struct.TypeMapModuleEntry {
		i32 u0x02000126, ; uint32_t type_token_id
		i32 92; uint32_t java_map_index
	}, ; 38
	%struct.TypeMapModuleEntry {
		i32 u0x02000128, ; uint32_t type_token_id
		i32 59; uint32_t java_map_index
	}, ; 39
	%struct.TypeMapModuleEntry {
		i32 u0x0200012e, ; uint32_t type_token_id
		i32 119; uint32_t java_map_index
	}, ; 40
	%struct.TypeMapModuleEntry {
		i32 u0x02000133, ; uint32_t type_token_id
		i32 35; uint32_t java_map_index
	} ; 41
], align 16

@module1_managed_to_java = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000002, ; uint32_t type_token_id
		i32 30; uint32_t java_map_index
	} ; 0
], align 4

; Java to managed map
@map_java = dso_local local_unnamed_addr constant [121 x %struct.TypeMapJava] [
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200006a, ; uint32_t type_token_id
		i32 10; uint32_t java_name_index
	}, ; 0
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000112, ; uint32_t type_token_id
		i32 87; uint32_t java_name_index
	}, ; 1
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200006b, ; uint32_t type_token_id
		i32 11; uint32_t java_name_index
	}, ; 2
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000dd, ; uint32_t type_token_id
		i32 51; uint32_t java_name_index
	}, ; 3
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200010e, ; uint32_t type_token_id
		i32 84; uint32_t java_name_index
	}, ; 4
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000085, ; uint32_t type_token_id
		i32 26; uint32_t java_name_index
	}, ; 5
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000b9, ; uint32_t type_token_id
		i32 40; uint32_t java_name_index
	}, ; 6
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000ae, ; uint32_t type_token_id
		i32 38; uint32_t java_name_index
	}, ; 7
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000e0, ; uint32_t type_token_id
		i32 54; uint32_t java_name_index
	}, ; 8
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000f7, ; uint32_t type_token_id
		i32 70; uint32_t java_name_index
	}, ; 9
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 68; uint32_t java_name_index
	}, ; 10
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200006e, ; uint32_t type_token_id
		i32 13; uint32_t java_name_index
	}, ; 11
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 24; uint32_t java_name_index
	}, ; 12
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000100, ; uint32_t type_token_id
		i32 75; uint32_t java_name_index
	}, ; 13
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000084, ; uint32_t type_token_id
		i32 25; uint32_t java_name_index
	}, ; 14
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200005c, ; uint32_t type_token_id
		i32 3; uint32_t java_name_index
	}, ; 15
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000127, ; uint32_t type_token_id
		i32 106; uint32_t java_name_index
	}, ; 16
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000073, ; uint32_t type_token_id
		i32 17; uint32_t java_name_index
	}, ; 17
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000059, ; uint32_t type_token_id
		i32 1; uint32_t java_name_index
	}, ; 18
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000070, ; uint32_t type_token_id
		i32 15; uint32_t java_name_index
	}, ; 19
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000135, ; uint32_t type_token_id
		i32 116; uint32_t java_name_index
	}, ; 20
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000111, ; uint32_t type_token_id
		i32 86; uint32_t java_name_index
	}, ; 21
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 62; uint32_t java_name_index
	}, ; 22
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200012b, ; uint32_t type_token_id
		i32 108; uint32_t java_name_index
	}, ; 23
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000ba, ; uint32_t type_token_id
		i32 41; uint32_t java_name_index
	}, ; 24
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000093, ; uint32_t type_token_id
		i32 35; uint32_t java_name_index
	}, ; 25
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000e7, ; uint32_t type_token_id
		i32 60; uint32_t java_name_index
	}, ; 26
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000de, ; uint32_t type_token_id
		i32 52; uint32_t java_name_index
	}, ; 27
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000108, ; uint32_t type_token_id
		i32 81; uint32_t java_name_index
	}, ; 28
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000d9, ; uint32_t type_token_id
		i32 49; uint32_t java_name_index
	}, ; 29
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000002, ; uint32_t type_token_id
		i32 120; uint32_t java_name_index
	}, ; 30
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000114, ; uint32_t type_token_id
		i32 89; uint32_t java_name_index
	}, ; 31
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000124, ; uint32_t type_token_id
		i32 104; uint32_t java_name_index
	}, ; 32
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200005e, ; uint32_t type_token_id
		i32 4; uint32_t java_name_index
	}, ; 33
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200008e, ; uint32_t type_token_id
		i32 33; uint32_t java_name_index
	}, ; 34
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000132, ; uint32_t type_token_id
		i32 114; uint32_t java_name_index
	}, ; 35
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200012f, ; uint32_t type_token_id
		i32 111; uint32_t java_name_index
	}, ; 36
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000087, ; uint32_t type_token_id
		i32 28; uint32_t java_name_index
	}, ; 37
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000089, ; uint32_t type_token_id
		i32 29; uint32_t java_name_index
	}, ; 38
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200006f, ; uint32_t type_token_id
		i32 14; uint32_t java_name_index
	}, ; 39
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200007c, ; uint32_t type_token_id
		i32 22; uint32_t java_name_index
	}, ; 40
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000d4, ; uint32_t type_token_id
		i32 47; uint32_t java_name_index
	}, ; 41
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000d2, ; uint32_t type_token_id
		i32 46; uint32_t java_name_index
	}, ; 42
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200011e, ; uint32_t type_token_id
		i32 99; uint32_t java_name_index
	}, ; 43
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 77; uint32_t java_name_index
	}, ; 44
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000101, ; uint32_t type_token_id
		i32 76; uint32_t java_name_index
	}, ; 45
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000e4, ; uint32_t type_token_id
		i32 57; uint32_t java_name_index
	}, ; 46
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000136, ; uint32_t type_token_id
		i32 117; uint32_t java_name_index
	}, ; 47
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000ef, ; uint32_t type_token_id
		i32 64; uint32_t java_name_index
	}, ; 48
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 83; uint32_t java_name_index
	}, ; 49
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000146, ; uint32_t type_token_id
		i32 119; uint32_t java_name_index
	}, ; 50
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000d0, ; uint32_t type_token_id
		i32 45; uint32_t java_name_index
	}, ; 51
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 21; uint32_t java_name_index
	}, ; 52
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000f6, ; uint32_t type_token_id
		i32 69; uint32_t java_name_index
	}, ; 53
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000b7, ; uint32_t type_token_id
		i32 39; uint32_t java_name_index
	}, ; 54
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200005b, ; uint32_t type_token_id
		i32 2; uint32_t java_name_index
	}, ; 55
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 61; uint32_t java_name_index
	}, ; 56
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000e6, ; uint32_t type_token_id
		i32 59; uint32_t java_name_index
	}, ; 57
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000080, ; uint32_t type_token_id
		i32 23; uint32_t java_name_index
	}, ; 58
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 94; uint32_t java_name_index
	}, ; 59
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200011d, ; uint32_t type_token_id
		i32 98; uint32_t java_name_index
	}, ; 60
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000fe, ; uint32_t type_token_id
		i32 74; uint32_t java_name_index
	}, ; 61
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 6; uint32_t java_name_index
	}, ; 62
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000113, ; uint32_t type_token_id
		i32 88; uint32_t java_name_index
	}, ; 63
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000c7, ; uint32_t type_token_id
		i32 43; uint32_t java_name_index
	}, ; 64
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000123, ; uint32_t type_token_id
		i32 103; uint32_t java_name_index
	}, ; 65
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000121, ; uint32_t type_token_id
		i32 101; uint32_t java_name_index
	}, ; 66
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000134, ; uint32_t type_token_id
		i32 115; uint32_t java_name_index
	}, ; 67
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000118, ; uint32_t type_token_id
		i32 93; uint32_t java_name_index
	}, ; 68
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000aa, ; uint32_t type_token_id
		i32 36; uint32_t java_name_index
	}, ; 69
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000092, ; uint32_t type_token_id
		i32 34; uint32_t java_name_index
	}, ; 70
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000e3, ; uint32_t type_token_id
		i32 56; uint32_t java_name_index
	}, ; 71
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000131, ; uint32_t type_token_id
		i32 113; uint32_t java_name_index
	}, ; 72
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000df, ; uint32_t type_token_id
		i32 53; uint32_t java_name_index
	}, ; 73
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000075, ; uint32_t type_token_id
		i32 19; uint32_t java_name_index
	}, ; 74
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 7; uint32_t java_name_index
	}, ; 75
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000104, ; uint32_t type_token_id
		i32 78; uint32_t java_name_index
	}, ; 76
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000e1, ; uint32_t type_token_id
		i32 55; uint32_t java_name_index
	}, ; 77
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200006c, ; uint32_t type_token_id
		i32 12; uint32_t java_name_index
	}, ; 78
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200011f, ; uint32_t type_token_id
		i32 100; uint32_t java_name_index
	}, ; 79
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200012a, ; uint32_t type_token_id
		i32 107; uint32_t java_name_index
	}, ; 80
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000db, ; uint32_t type_token_id
		i32 50; uint32_t java_name_index
	}, ; 81
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200011a, ; uint32_t type_token_id
		i32 95; uint32_t java_name_index
	}, ; 82
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000117, ; uint32_t type_token_id
		i32 92; uint32_t java_name_index
	}, ; 83
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200008b, ; uint32_t type_token_id
		i32 31; uint32_t java_name_index
	}, ; 84
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 9; uint32_t java_name_index
	}, ; 85
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000072, ; uint32_t type_token_id
		i32 16; uint32_t java_name_index
	}, ; 86
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200008a, ; uint32_t type_token_id
		i32 30; uint32_t java_name_index
	}, ; 87
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200011c, ; uint32_t type_token_id
		i32 97; uint32_t java_name_index
	}, ; 88
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000115, ; uint32_t type_token_id
		i32 90; uint32_t java_name_index
	}, ; 89
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000076, ; uint32_t type_token_id
		i32 20; uint32_t java_name_index
	}, ; 90
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000122, ; uint32_t type_token_id
		i32 102; uint32_t java_name_index
	}, ; 91
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000125, ; uint32_t type_token_id
		i32 105; uint32_t java_name_index
	}, ; 92
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000107, ; uint32_t type_token_id
		i32 80; uint32_t java_name_index
	}, ; 93
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000ac, ; uint32_t type_token_id
		i32 37; uint32_t java_name_index
	}, ; 94
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 32; uint32_t java_name_index
	}, ; 95
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000d5, ; uint32_t type_token_id
		i32 48; uint32_t java_name_index
	}, ; 96
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000116, ; uint32_t type_token_id
		i32 91; uint32_t java_name_index
	}, ; 97
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000086, ; uint32_t type_token_id
		i32 27; uint32_t java_name_index
	}, ; 98
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000137, ; uint32_t type_token_id
		i32 118; uint32_t java_name_index
	}, ; 99
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 8; uint32_t java_name_index
	}, ; 100
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 85; uint32_t java_name_index
	}, ; 101
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000130, ; uint32_t type_token_id
		i32 112; uint32_t java_name_index
	}, ; 102
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000f9, ; uint32_t type_token_id
		i32 71; uint32_t java_name_index
	}, ; 103
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000f0, ; uint32_t type_token_id
		i32 65; uint32_t java_name_index
	}, ; 104
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000f1, ; uint32_t type_token_id
		i32 66; uint32_t java_name_index
	}, ; 105
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200011b, ; uint32_t type_token_id
		i32 96; uint32_t java_name_index
	}, ; 106
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000fb, ; uint32_t type_token_id
		i32 72; uint32_t java_name_index
	}, ; 107
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 5; uint32_t java_name_index
	}, ; 108
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 82; uint32_t java_name_index
	}, ; 109
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000fd, ; uint32_t type_token_id
		i32 73; uint32_t java_name_index
	}, ; 110
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000106, ; uint32_t type_token_id
		i32 79; uint32_t java_name_index
	}, ; 111
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000074, ; uint32_t type_token_id
		i32 18; uint32_t java_name_index
	}, ; 112
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x0200012c, ; uint32_t type_token_id
		i32 109; uint32_t java_name_index
	}, ; 113
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000e5, ; uint32_t type_token_id
		i32 58; uint32_t java_name_index
	}, ; 114
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000f2, ; uint32_t type_token_id
		i32 67; uint32_t java_name_index
	}, ; 115
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000cf, ; uint32_t type_token_id
		i32 44; uint32_t java_name_index
	}, ; 116
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000057, ; uint32_t type_token_id
		i32 0; uint32_t java_name_index
	}, ; 117
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x020000bb, ; uint32_t type_token_id
		i32 42; uint32_t java_name_index
	}, ; 118
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 110; uint32_t java_name_index
	}, ; 119
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 63; uint32_t java_name_index
	} ; 120
], align 16

; Java type names
@java_type_names = dso_local local_unnamed_addr constant [121 x ptr] [
	ptr @.str.0, ; 0
	ptr @.str.1, ; 1
	ptr @.str.2, ; 2
	ptr @.str.3, ; 3
	ptr @.str.4, ; 4
	ptr @.str.5, ; 5
	ptr @.str.6, ; 6
	ptr @.str.7, ; 7
	ptr @.str.8, ; 8
	ptr @.str.9, ; 9
	ptr @.str.10, ; 10
	ptr @.str.11, ; 11
	ptr @.str.12, ; 12
	ptr @.str.13, ; 13
	ptr @.str.14, ; 14
	ptr @.str.15, ; 15
	ptr @.str.16, ; 16
	ptr @.str.17, ; 17
	ptr @.str.18, ; 18
	ptr @.str.19, ; 19
	ptr @.str.20, ; 20
	ptr @.str.21, ; 21
	ptr @.str.22, ; 22
	ptr @.str.23, ; 23
	ptr @.str.24, ; 24
	ptr @.str.25, ; 25
	ptr @.str.26, ; 26
	ptr @.str.27, ; 27
	ptr @.str.28, ; 28
	ptr @.str.29, ; 29
	ptr @.str.30, ; 30
	ptr @.str.31, ; 31
	ptr @.str.32, ; 32
	ptr @.str.33, ; 33
	ptr @.str.34, ; 34
	ptr @.str.35, ; 35
	ptr @.str.36, ; 36
	ptr @.str.37, ; 37
	ptr @.str.38, ; 38
	ptr @.str.39, ; 39
	ptr @.str.40, ; 40
	ptr @.str.41, ; 41
	ptr @.str.42, ; 42
	ptr @.str.43, ; 43
	ptr @.str.44, ; 44
	ptr @.str.45, ; 45
	ptr @.str.46, ; 46
	ptr @.str.47, ; 47
	ptr @.str.48, ; 48
	ptr @.str.49, ; 49
	ptr @.str.50, ; 50
	ptr @.str.51, ; 51
	ptr @.str.52, ; 52
	ptr @.str.53, ; 53
	ptr @.str.54, ; 54
	ptr @.str.55, ; 55
	ptr @.str.56, ; 56
	ptr @.str.57, ; 57
	ptr @.str.58, ; 58
	ptr @.str.59, ; 59
	ptr @.str.60, ; 60
	ptr @.str.61, ; 61
	ptr @.str.62, ; 62
	ptr @.str.63, ; 63
	ptr @.str.64, ; 64
	ptr @.str.65, ; 65
	ptr @.str.66, ; 66
	ptr @.str.67, ; 67
	ptr @.str.68, ; 68
	ptr @.str.69, ; 69
	ptr @.str.70, ; 70
	ptr @.str.71, ; 71
	ptr @.str.72, ; 72
	ptr @.str.73, ; 73
	ptr @.str.74, ; 74
	ptr @.str.75, ; 75
	ptr @.str.76, ; 76
	ptr @.str.77, ; 77
	ptr @.str.78, ; 78
	ptr @.str.79, ; 79
	ptr @.str.80, ; 80
	ptr @.str.81, ; 81
	ptr @.str.82, ; 82
	ptr @.str.83, ; 83
	ptr @.str.84, ; 84
	ptr @.str.85, ; 85
	ptr @.str.86, ; 86
	ptr @.str.87, ; 87
	ptr @.str.88, ; 88
	ptr @.str.89, ; 89
	ptr @.str.90, ; 90
	ptr @.str.91, ; 91
	ptr @.str.92, ; 92
	ptr @.str.93, ; 93
	ptr @.str.94, ; 94
	ptr @.str.95, ; 95
	ptr @.str.96, ; 96
	ptr @.str.97, ; 97
	ptr @.str.98, ; 98
	ptr @.str.99, ; 99
	ptr @.str.100, ; 100
	ptr @.str.101, ; 101
	ptr @.str.102, ; 102
	ptr @.str.103, ; 103
	ptr @.str.104, ; 104
	ptr @.str.105, ; 105
	ptr @.str.106, ; 106
	ptr @.str.107, ; 107
	ptr @.str.108, ; 108
	ptr @.str.109, ; 109
	ptr @.str.110, ; 110
	ptr @.str.111, ; 111
	ptr @.str.112, ; 112
	ptr @.str.113, ; 113
	ptr @.str.114, ; 114
	ptr @.str.115, ; 115
	ptr @.str.116, ; 116
	ptr @.str.117, ; 117
	ptr @.str.118, ; 118
	ptr @.str.119, ; 119
	ptr @.str.120 ; 120
], align 16

; Strings
@.str.0 = private unnamed_addr constant [32 x i8] c"javax/security/cert/Certificate\00", align 16
@.str.1 = private unnamed_addr constant [36 x i8] c"javax/security/cert/X509Certificate\00", align 16
@.str.2 = private unnamed_addr constant [28 x i8] c"javax/security/auth/Subject\00", align 16
@.str.3 = private unnamed_addr constant [24 x i8] c"javax/net/SocketFactory\00", align 16
@.str.4 = private unnamed_addr constant [33 x i8] c"javax/net/ssl/HttpsURLConnection\00", align 16
@.str.5 = private unnamed_addr constant [31 x i8] c"javax/net/ssl/HostnameVerifier\00", align 16
@.str.6 = private unnamed_addr constant [25 x i8] c"javax/net/ssl/KeyManager\00", align 16
@.str.7 = private unnamed_addr constant [25 x i8] c"javax/net/ssl/SSLSession\00", align 16
@.str.8 = private unnamed_addr constant [32 x i8] c"javax/net/ssl/SSLSessionContext\00", align 16
@.str.9 = private unnamed_addr constant [27 x i8] c"javax/net/ssl/TrustManager\00", align 16
@.str.10 = private unnamed_addr constant [32 x i8] c"javax/net/ssl/KeyManagerFactory\00", align 16
@.str.11 = private unnamed_addr constant [25 x i8] c"javax/net/ssl/SSLContext\00", align 16
@.str.12 = private unnamed_addr constant [31 x i8] c"javax/net/ssl/SSLSocketFactory\00", align 16
@.str.13 = private unnamed_addr constant [34 x i8] c"javax/net/ssl/TrustManagerFactory\00", align 16
@.str.14 = private unnamed_addr constant [24 x i8] c"android/widget/TextView\00", align 16
@.str.15 = private unnamed_addr constant [26 x i8] c"android/widget/AbsSeekBar\00", align 16
@.str.16 = private unnamed_addr constant [22 x i8] c"android/widget/Button\00", align 16
@.str.17 = private unnamed_addr constant [24 x i8] c"android/widget/EditText\00", align 16
@.str.18 = private unnamed_addr constant [28 x i8] c"android/widget/LinearLayout\00", align 16
@.str.19 = private unnamed_addr constant [27 x i8] c"android/widget/ProgressBar\00", align 16
@.str.20 = private unnamed_addr constant [23 x i8] c"android/widget/SeekBar\00", align 16
@.str.21 = private unnamed_addr constant [47 x i8] c"android/widget/SeekBar$OnSeekBarChangeListener\00", align 16
@.str.22 = private unnamed_addr constant [63 x i8] c"mono/android/widget/SeekBar_OnSeekBarChangeListenerImplementor\00", align 16
@.str.23 = private unnamed_addr constant [21 x i8] c"android/widget/Toast\00", align 16
@.str.24 = private unnamed_addr constant [26 x i8] c"android/util/AttributeSet\00", align 16
@.str.25 = private unnamed_addr constant [19 x i8] c"android/os/Handler\00", align 16
@.str.26 = private unnamed_addr constant [22 x i8] c"android/os/BaseBundle\00", align 16
@.str.27 = private unnamed_addr constant [17 x i8] c"android/os/Build\00", align 16
@.str.28 = private unnamed_addr constant [25 x i8] c"android/os/Build$VERSION\00", align 16
@.str.29 = private unnamed_addr constant [18 x i8] c"android/os/Bundle\00", align 16
@.str.30 = private unnamed_addr constant [18 x i8] c"android/os/Looper\00", align 16
@.str.31 = private unnamed_addr constant [18 x i8] c"android/view/View\00", align 16
@.str.32 = private unnamed_addr constant [34 x i8] c"android/view/View$OnClickListener\00", align 16
@.str.33 = private unnamed_addr constant [50 x i8] c"mono/android/view/View_OnClickListenerImplementor\00", align 16
@.str.34 = private unnamed_addr constant [33 x i8] c"android/view/ContextThemeWrapper\00", align 16
@.str.35 = private unnamed_addr constant [23 x i8] c"android/view/ViewGroup\00", align 16
@.str.36 = private unnamed_addr constant [40 x i8] c"mono/android/runtime/InputStreamAdapter\00", align 16
@.str.37 = private unnamed_addr constant [21 x i8] c"java/util/Collection\00", align 16
@.str.38 = private unnamed_addr constant [18 x i8] c"java/util/HashMap\00", align 16
@.str.39 = private unnamed_addr constant [20 x i8] c"java/util/ArrayList\00", align 16
@.str.40 = private unnamed_addr constant [32 x i8] c"mono/android/runtime/JavaObject\00", align 16
@.str.41 = private unnamed_addr constant [35 x i8] c"android/runtime/JavaProxyThrowable\00", align 16
@.str.42 = private unnamed_addr constant [18 x i8] c"java/util/HashSet\00", align 16
@.str.43 = private unnamed_addr constant [41 x i8] c"mono/android/runtime/OutputStreamAdapter\00", align 16
@.str.44 = private unnamed_addr constant [23 x i8] c"android/graphics/Color\00", align 16
@.str.45 = private unnamed_addr constant [24 x i8] c"android/content/Context\00", align 16
@.str.46 = private unnamed_addr constant [31 x i8] c"android/content/ContextWrapper\00", align 16
@.str.47 = private unnamed_addr constant [21 x i8] c"android/app/Activity\00", align 16
@.str.48 = private unnamed_addr constant [24 x i8] c"android/app/Application\00", align 16
@.str.49 = private unnamed_addr constant [26 x i8] c"java/net/ConnectException\00", align 16
@.str.50 = private unnamed_addr constant [27 x i8] c"java/net/HttpURLConnection\00", align 16
@.str.51 = private unnamed_addr constant [27 x i8] c"java/net/InetSocketAddress\00", align 16
@.str.52 = private unnamed_addr constant [27 x i8] c"java/net/ProtocolException\00", align 16
@.str.53 = private unnamed_addr constant [15 x i8] c"java/net/Proxy\00", align 1
@.str.54 = private unnamed_addr constant [20 x i8] c"java/net/Proxy$Type\00", align 16
@.str.55 = private unnamed_addr constant [23 x i8] c"java/net/SocketAddress\00", align 16
@.str.56 = private unnamed_addr constant [25 x i8] c"java/net/SocketException\00", align 16
@.str.57 = private unnamed_addr constant [32 x i8] c"java/net/SocketTimeoutException\00", align 16
@.str.58 = private unnamed_addr constant [33 x i8] c"java/net/UnknownServiceException\00", align 16
@.str.59 = private unnamed_addr constant [13 x i8] c"java/net/URL\00", align 1
@.str.60 = private unnamed_addr constant [23 x i8] c"java/net/URLConnection\00", align 16
@.str.61 = private unnamed_addr constant [18 x i8] c"java/security/Key\00", align 16
@.str.62 = private unnamed_addr constant [24 x i8] c"java/security/Principal\00", align 16
@.str.63 = private unnamed_addr constant [25 x i8] c"java/security/PrivateKey\00", align 16
@.str.64 = private unnamed_addr constant [25 x i8] c"java/security/KeyFactory\00", align 16
@.str.65 = private unnamed_addr constant [23 x i8] c"java/security/KeyStore\00", align 16
@.str.66 = private unnamed_addr constant [27 x i8] c"java/security/SecureRandom\00", align 16
@.str.67 = private unnamed_addr constant [34 x i8] c"java/security/spec/EncodedKeySpec\00", align 16
@.str.68 = private unnamed_addr constant [27 x i8] c"java/security/spec/KeySpec\00", align 16
@.str.69 = private unnamed_addr constant [39 x i8] c"java/security/spec/PKCS8EncodedKeySpec\00", align 16
@.str.70 = private unnamed_addr constant [31 x i8] c"java/security/cert/Certificate\00", align 16
@.str.71 = private unnamed_addr constant [30 x i8] c"java/nio/channels/FileChannel\00", align 16
@.str.72 = private unnamed_addr constant [51 x i8] c"java/nio/channels/spi/AbstractInterruptibleChannel\00", align 16
@.str.73 = private unnamed_addr constant [24 x i8] c"java/io/FileInputStream\00", align 16
@.str.74 = private unnamed_addr constant [20 x i8] c"java/io/InputStream\00", align 16
@.str.75 = private unnamed_addr constant [31 x i8] c"java/io/InterruptedIOException\00", align 16
@.str.76 = private unnamed_addr constant [20 x i8] c"java/io/IOException\00", align 16
@.str.77 = private unnamed_addr constant [21 x i8] c"java/io/Serializable\00", align 16
@.str.78 = private unnamed_addr constant [21 x i8] c"java/io/OutputStream\00", align 16
@.str.79 = private unnamed_addr constant [20 x i8] c"java/io/PrintWriter\00", align 16
@.str.80 = private unnamed_addr constant [21 x i8] c"java/io/StringWriter\00", align 16
@.str.81 = private unnamed_addr constant [15 x i8] c"java/io/Writer\00", align 1
@.str.82 = private unnamed_addr constant [22 x i8] c"java/util/Enumeration\00", align 16
@.str.83 = private unnamed_addr constant [19 x i8] c"java/util/Iterator\00", align 16
@.str.84 = private unnamed_addr constant [17 x i8] c"java/util/Random\00", align 16
@.str.85 = private unnamed_addr constant [28 x i8] c"java/util/function/Consumer\00", align 16
@.str.86 = private unnamed_addr constant [18 x i8] c"java/lang/Boolean\00", align 16
@.str.87 = private unnamed_addr constant [15 x i8] c"java/lang/Byte\00", align 1
@.str.88 = private unnamed_addr constant [20 x i8] c"java/lang/Character\00", align 16
@.str.89 = private unnamed_addr constant [16 x i8] c"java/lang/Class\00", align 16
@.str.90 = private unnamed_addr constant [33 x i8] c"java/lang/ClassNotFoundException\00", align 16
@.str.91 = private unnamed_addr constant [17 x i8] c"java/lang/Double\00", align 16
@.str.92 = private unnamed_addr constant [20 x i8] c"java/lang/Exception\00", align 16
@.str.93 = private unnamed_addr constant [16 x i8] c"java/lang/Float\00", align 16
@.str.94 = private unnamed_addr constant [23 x i8] c"java/lang/CharSequence\00", align 16
@.str.95 = private unnamed_addr constant [18 x i8] c"java/lang/Integer\00", align 16
@.str.96 = private unnamed_addr constant [15 x i8] c"java/lang/Long\00", align 1
@.str.97 = private unnamed_addr constant [17 x i8] c"java/lang/Object\00", align 16
@.str.98 = private unnamed_addr constant [27 x i8] c"java/lang/RuntimeException\00", align 16
@.str.99 = private unnamed_addr constant [16 x i8] c"java/lang/Short\00", align 16
@.str.100 = private unnamed_addr constant [17 x i8] c"java/lang/String\00", align 16
@.str.101 = private unnamed_addr constant [17 x i8] c"java/lang/Thread\00", align 16
@.str.102 = private unnamed_addr constant [35 x i8] c"mono/java/lang/RunnableImplementor\00", align 16
@.str.103 = private unnamed_addr constant [20 x i8] c"java/lang/Throwable\00", align 16
@.str.104 = private unnamed_addr constant [29 x i8] c"java/lang/ClassCastException\00", align 16
@.str.105 = private unnamed_addr constant [15 x i8] c"java/lang/Enum\00", align 1
@.str.106 = private unnamed_addr constant [16 x i8] c"java/lang/Error\00", align 16
@.str.107 = private unnamed_addr constant [35 x i8] c"java/lang/IllegalArgumentException\00", align 16
@.str.108 = private unnamed_addr constant [32 x i8] c"java/lang/IllegalStateException\00", align 16
@.str.109 = private unnamed_addr constant [36 x i8] c"java/lang/IndexOutOfBoundsException\00", align 16
@.str.110 = private unnamed_addr constant [19 x i8] c"java/lang/Runnable\00", align 16
@.str.111 = private unnamed_addr constant [23 x i8] c"java/lang/LinkageError\00", align 16
@.str.112 = private unnamed_addr constant [31 x i8] c"java/lang/NoClassDefFoundError\00", align 16
@.str.113 = private unnamed_addr constant [31 x i8] c"java/lang/NullPointerException\00", align 16
@.str.114 = private unnamed_addr constant [17 x i8] c"java/lang/Number\00", align 16
@.str.115 = private unnamed_addr constant [39 x i8] c"java/lang/ReflectiveOperationException\00", align 16
@.str.116 = private unnamed_addr constant [28 x i8] c"java/lang/SecurityException\00", align 16
@.str.117 = private unnamed_addr constant [28 x i8] c"java/lang/StackTraceElement\00", align 16
@.str.118 = private unnamed_addr constant [40 x i8] c"java/lang/UnsupportedOperationException\00", align 16
@.str.119 = private unnamed_addr constant [25 x i8] c"mono/android/TypeManager\00", align 16
@.str.120 = private unnamed_addr constant [35 x i8] c"crc64a6e0c00971f6cd91/MainActivity\00", align 16

;TypeMapModule
@.TypeMapModule.0_assembly_name = private unnamed_addr constant [13 x i8] c"Mono.Android\00", align 1
@.TypeMapModule.1_assembly_name = private unnamed_addr constant [12 x i8] c"AndroidApp1\00", align 1

; Metadata
!llvm.module.flags = !{!0, !1}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!".NET for Android remotes/origin/release/9.0.1xx @ 9abff7703206541fdb83ffa80fe2c2753ad1997b"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
