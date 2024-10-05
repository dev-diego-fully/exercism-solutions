//@ts-check

/**
 * EXPORTEDS FUNCTIONS
 */

/**
 * 
 * @param {(...args: any) => any} promisified 
 * @returns {(...args: any) => Promise<any>}
 */
export const promisify = (promisified) => {

  return (...args) => {
    return new Promise(
      (resolve, reject) => {
        promisified(...args, callbackAdapterForPromises(resolve, reject))
      }
    );
  }
};

/**
 * 
 * @param {Promise<any>[]} promises
 * @returns {Promise<any[]|undefined>}
 */
export const all = (promises) => {

  if (promises === undefined) {
    return Promise.resolve(undefined);
  }

  if (promises.length === 0) {
    return Promise.resolve([]);
  }

  return new Promise(
    (resolve, reject) => {
      const resolveds = [];
      let resolvedCount = 0;

      const partialResolve = (value, index) => {
        resolveds[index] = value;
        resolvedCount++;

        if (resolvedCount === promises.length) {
          resolve(resolveds);
        }
      }

      for (const index in promises) {
        promises[index]
          .then((v) => partialResolve(v, index))
          .catch((r) => reject(r));
      }
    }
  );
};

/**
 * 
 * @param {Promise<any>[]} promises 
 * @returns {Promise<any[]|undefined>}
 */
export const allSettled = (promises) => {
  if (promises === undefined) {
    return Promise.resolve(undefined);
  }

  if (promises.length === 0) {
    return Promise.resolve([]);
  }

  return new Promise(
    (resolve, reject) => {
      const results = [];
      let finisheds = 0;
      
      const partialResult = (value, index) => {
        results[index] = value;
        finisheds++;
        if(finisheds >= promises.length) {
          resolve(results);
        }
      }

      for(const index in promises) {
        promises[index]
          .then((v) => partialResult(v, index))
          .catch((e) => partialResult(e, index));
      }
    }
  );
};

/**
 * 
 * @param {Promise<any>[]} promises 
 * @returns {Promise<any>}
 */
export const race = (promises) => {
  if (promises === undefined) {
    return Promise.resolve(undefined);
  }

  if (promises.length === 0) {
    return Promise.resolve([]);
  }

  return new Promise(
    (resolve, reject) => {
      for (const promise of promises) {
        promise
          .then((v) => resolve(v))
          .catch((e) => reject(e));
      }
    }
  );
};

/**
 * 
 * @param {Promise<any>[]} promises 
 * @returns {Promise}
 */
export const any = (promises) => {

  if (promises === undefined) {
    return Promise.resolve();
  }

  if (promises.length === 0) {
    return Promise.resolve([]);
  }

  return new Promise(
    (resolve, reject) => {
      const rejecteds = [];
      const partialReject = (r) => {
        rejecteds.push(r);
        if (rejecteds.length === promises.length) {
          reject(rejecteds);
        }
      }

      for (const promise of promises) {
        promise
          .then((v) => resolve(v))
          .catch((e) => partialReject(e))
      }
    }
  );

};


/**
 * 
 * @param {(value: any) => void} promiseResolver 
 * @param {(reason?: any) => void} promiseRejector 
 * @returns {(error: any, value: any) => void}
 */
function callbackAdapterForPromises(promiseResolver, promiseRejector) {
  return (error, value) => {
    if (error == null) {
      return promiseResolver(value);
    }
    return promiseRejector(error);
  }
}